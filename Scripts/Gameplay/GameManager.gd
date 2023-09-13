class_name Game_Manager extends Node

signal action_added(action)
signal action_removed(index)
signal on_victory(perfectPercentage)
signal on_defeat(index)
signal on_defeat_delay_needed(index)
signal startedPlay()

@export var player = CharacterBody2D.new()
@export var httpReq:HTTP_REQUESTS = HTTP_REQUESTS.new()

var selectedActions
var playQueue = []

var perfect_steps:float = 0

#rules var
var movementsExecuted:int = 0
var blocks:Dictionary
var win = false
var stopChecking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	player.movement_finished.connect(playerReachedPos)
	httpReq.data_retrieved.connect(set_perfect_steps)

#public------
func PlayCommands():
	
	if _getActionsList().size() == 0: 
		return false
	
	emit_signal("startedPlay")
	
	for action in _getActionsList():
		playQueue.push_back(action.get_node("Button").dir)
	playerReachedPos(Vector2.ZERO)
	
	return true

func SetBlocks(blocklist):
	print("block list setted")
	blocks = blocklist
	print(blocks.keys())
	
func AddCommand(action):
	emit_signal("action_added", action)
	
func RemoveCommand(index):
	emit_signal("action_removed", index)
	
func SetSelectedActionsReference(sel):
	selectedActions = sel
	
#private-------
func _checkNewBlock(playerPos):
	var blockNumber = playerPos.x / player.MOVEMENT_OFFSET_X
	print("PLAYER POS " + str(playerPos))
	blockNumber = round(blockNumber)
	
	movementsExecuted += 1
	
	var stringedPos = str(Vector2(round(playerPos.x), round(playerPos.y)))
	if (playerPos.x < 0 || !blocks.has(stringedPos)):
		defeat_delay()
		print("PERDI POR ACA fst cond " + str(playerPos.x < 0) + " snd cond " + str(!blocks.has(playerPos)))
		return true
	else:
		var block = blocks[stringedPos]
		
		win = block is FinishBlock
		return false
	
	
func _play(pos):
	focusCurrentAction()
	player.movePlayerToDir(pos)

func _getActionsList():
	return selectedActions.list
	
func _checkIfWon(pos):
	if (win):
		emit_signal("on_victory", (perfect_steps / movementsExecuted) * 100)
	elif (pos != Vector2.ZERO):
		defeat()
		
func defeat():
	emit_signal("on_defeat")
	
func defeat_delay():
	emit_signal("on_defeat_delay_needed")
	
func focusCurrentAction():
	if (movementsExecuted > 0): #unfocus previous node
		_getActionsList()[movementsExecuted -1].get_node("Button")._elemUnfocused()	
	#focus current node
	_getActionsList()[movementsExecuted].get_node("Button")._elemFocused()

#event callbacks-------
func playerReachedPos(pos):
	if pos != Vector2.ZERO:
		stopChecking = _checkNewBlock(pos)
		
	if stopChecking:
		return
	
	await get_tree().create_timer(1.0).timeout
	if (playQueue.size() > 0):
		_play(playQueue.pop_front())
	else:
		_checkIfWon(pos)
		
func set_perfect_steps(data):
	var level:LevelStructure = LevelStructure.new(data)
	perfect_steps = level.perfect_steps




