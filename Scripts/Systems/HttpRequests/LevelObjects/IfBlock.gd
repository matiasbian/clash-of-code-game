class_name IfBlock extends BaseGameBlock

var subinstance
var subtype
var value

func _init(block):
	super._init(block)
	subtype = block.subtype
	value = block.value
	
func get_subinstance():
	if (subtype == "spikes"):
		_get_spikes_sub_instance()
	elif subinstance == "balls":
		_get_balls_sub_instance()
		

func do_extras_when_landed(player):
	super(player)
	subinstance.do_extras_when_landed(player)
	
func shouldLose(player):
	subinstance.come_from_if()
	return subinstance.shouldLose(player)
	
	
#AUX
func _get_spikes_sub_instance():
	if !subinstance:
		var randomN = randi() % 2
		var block = _block 
		var curr_command = _inst.game_manager.current_command
		
		curr_command
		
		if curr_command is IFButton:
			if randomN == 0 && !curr_command.is_wrong_true_branch():
				subinstance = MovementBlock.new(block)
			else:
				subinstance = JumpBlock.new(block)
		else:
			if curr_command is JumpButton:
				subinstance = MovementBlock.new(block)
			else:
				subinstance = JumpBlock.new(block)

	return subinstance
	
func _get_balls_sub_instance():
	pass