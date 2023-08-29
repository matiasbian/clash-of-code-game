extends Node

signal action_added(action)
signal action_removed(index)

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
	
	print("block number " + str(blockNumber))
	
	if (playerPos.x < 0 || blockNumber > blocks.size() -1):
		print("Perdiste")
	else:
		var block = blocks[blockNumber]
		
		win = block is FinishBlock
	
	
func _play(pos):
	player.movePlayerToDir(pos)

func _getActionsList():
	return selectedActions.list
	
func _checkIfWon():
	if (win):
		print("Ganaste!!")

#event callbacks-------
func playerReachedPos(pos):
	if pos != Vector2.ZERO:
		_checkNewBlock(pos)
		
	await get_tree().create_timer(1.0).timeout
	if (playQueue.size() > 0):
		_play(playQueue.pop_front())
	else:
		_checkIfWon()




