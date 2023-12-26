class_name Game_Manager extends Node

signal action_added(action)
signal procedure_added(procedure)
signal action_removed(index)
signal on_victory(perfectPercentage)
signal on_defeat(index)
signal on_defeat_delay_needed(index)
signal startedPlay()
signal on_block_enter(block)
signal on_step_performed(number)
signal jumps_updated(jumps)
signal on_level_loaded()

@export var player:Player = Player.new()
@export var httpReq:HTTP_REQUESTS = HTTP_REQUESTS.new()

var selectedActions
var playQueue = []

var perfect_steps:float = 0

#rules var
var jumps_availables:int = 0
var movementsExecuted:int = 0
var block_index:int = 0

var blocks:Dictionary
var win = false
var stopChecking = false
var current_command

var global_procedures:Array = []

@onready var time_manager:TimeManager = %TimeManager

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
		_get_next_queue().push_back(action.get_node("Button"))
	playerReachedPos(Vector2.ZERO)
	
	return true

func SetBlocks(blocklist):
	blocks = blocklist
	emit_signal("on_level_loaded")
	
func AddCommand(action):
	emit_signal("action_added", action)
	
	if (action is JumpButton):
		add_jumps(-1)
		
func add_procedure(procedure):
	emit_signal("procedure_added", procedure)
	
func RemoveCommand(index):
	emit_signal("action_removed", index)
	
func SetSelectedActionsReference(sel):
	selectedActions = sel
	
#private-------
func _checkNewBlock(playerPos):
	var blockNumber = playerPos.x / player.MOVEMENT_OFFSET_X
	blockNumber = round(blockNumber)
	
	movementsExecuted += 1
	block_index += 1
	emit_signal("on_step_performed", movementsExecuted, perfect_steps)
	
	var stringedPos = str(Vector2(round(playerPos.x), round(playerPos.y)))
	
	#out of level losing
	if (playerPos.x < 0 || !blocks.has(stringedPos)):
		defeat_delay()
		return true
	else:
		var block = blocks[stringedPos]
		emit_signal("on_block_enter", block)
		#Check if this block losing logic
		block.do_extras_when_landed(player)	
		if (block.should_lose_on_enter(player)):
			defeat_delay()
			return true
		
		win = block is FinishBlock
		return false
	
	
func _play(action, focus_in_selected_commands = true):
	if (focus_in_selected_commands): 
		focusCurrentAction()
		current_command = action
	else:
		block_index -= 1
	player.execute_command(action)


func _getActionsList():
	return selectedActions.list
	
func _checkIfWon(pos):
	if (win):
		emit_signal("on_victory", (perfect_steps / movementsExecuted) * 100)
	elif (pos != Vector2.ZERO):
		defeat_delay()
		
func defeat():
	emit_signal("on_defeat")
	
func defeat_delay():
	emit_signal("on_defeat_delay_needed")
	
func focusCurrentAction():
	if (block_index > 0): #unfocus previous node
		_getActionsList()[block_index -1].get_node("Button")._elemUnfocused()	
	#focus current node
	_getActionsList()[block_index].get_node("Button")._elemFocused()

#event callbacks-------
func playerReachedPos(pos):
	if pos != Vector2.ZERO:
		stopChecking = _checkNewBlock(pos)
		
	if stopChecking:
		return
		
	if ((!current_command || current_command.procedure.is_empty()) && _get_next_queue().size() == 0):
		_checkIfWon(pos)
		return
	
	await get_tree().create_timer(1.0).timeout
	
	#first check if action has subactions, if not, pop from actions list
	if (current_command && !current_command.procedure.is_empty()):
		var subelem = current_command.pop_from_subqueue()
		_play(subelem, false)
		return
	
	if (_get_next_queue().size() > 0):
		var stringedPos = str(Vector2(round(pos.x), round(pos.y)))
		var block = blocks[stringedPos]
		
		var newBlock = _get_next_queue().pop_front()
		
		if (newBlock is DirButton && current_command && block.should_lose_on_leave(player)):
			defeat_delay()
			return
			
		_play(newBlock)
		
func get_next_command():
	if _get_next_queue().size() > 0:
		return _get_next_queue()[0]
	
	return null	
func set_perfect_steps(data):
	var level:LevelStructure = LevelStructure.new(data)
	perfect_steps = level.perfect_steps
	httpReq.data_retrieved.disconnect(set_perfect_steps)
	
	var ui = get_parent().get_parent().get_node("UI/Panel/PopUps")
	if ui:
		ui._show_dialog(level.dialogs, level.levelNumber)
	emit_signal("on_step_performed", 0, perfect_steps)	
	

func _get_next_queue():
	return playQueue
	
func get_block(pos):
	var stringedPos = str(Vector2(round(pos.x), round(pos.y)))
	if (blocks.has(stringedPos)):
		return blocks[stringedPos]
	else:
		return null
		
func add_jumps(jumps):
	jumps_availables += jumps
	emit_signal("jumps_updated", jumps_availables)

	


