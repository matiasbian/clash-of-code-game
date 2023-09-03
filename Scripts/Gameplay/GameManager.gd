class_name Game_Manager extends Node

signal action_added(action)
signal action_removed(index)
signal on_victory()
signal on_defeat(index)

@export var player = CharacterBody2D.new()

var selectedActions
var playQueue = []

#rules var
var movementsExecuted:int = 0
var blocks = []
var win = false

# Called when the node enters the scene tree for the first time.
func _ready():
	player.movement_finished.connect(playerReachedPos)

#public------
func PlayCommands():
	
	
	for action in _getActionsList():
		playQueue.push_back(action.get_node("Button").dir)
	playerReachedPos(Vector2.ZERO)

func SetBlocks(blocklist):
	print("block list setted")
	blocks = blocklist
	
func AddCommand(action):
	emit_signal("action_added", action)
	
func RemoveCommand(index):
	emit_signal("action_removed", index)
	
func SetSelectedActionsReference(sel):
	selectedActions = sel
	
#private-------
func _checkNewBlock(playerPos):
	var blockNumber = playerPos.x / player.MOVEMENT_OFFSET_X
	blockNumber = round(blockNumber)
	
	movementsExecuted += 1
	
	if (playerPos.x < 0 || blockNumber > blocks.size() -1):
		defeat()
	else:
		var block = blocks[blockNumber]
		
		win = block is FinishBlock
	
	
func _play(pos):
	focusCurrentAction()
	player.movePlayerToDir(pos)

func _getActionsList():
	return selectedActions.list
	
func _checkIfWon(pos):
	if (win):
		emit_signal("on_victory")
	elif (pos != Vector2.ZERO):
		emit_signal("on_defeat")
		
func defeat():
	emit_signal("on_defeat")
	
func focusCurrentAction():
	if (movementsExecuted > 0): #unfocus previous node
		_getActionsList()[movementsExecuted -1].get_node("Button")._elemUnfocused()	
	#focus current node
	_getActionsList()[movementsExecuted].get_node("Button")._elemFocused()

#event callbacks-------
func playerReachedPos(pos):
	if pos != Vector2.ZERO:
		_checkNewBlock(pos)
		
	await get_tree().create_timer(1.0).timeout
	if (playQueue.size() > 0):
		_play(playQueue.pop_front())
	else:
		_checkIfWon(pos)




