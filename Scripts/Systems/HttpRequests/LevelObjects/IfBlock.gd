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
		return _get_spikes_sub_instance()
	elif subtype == "balls":
		return _get_balls_sub_instance()
		

func do_extras_when_landed(player):
	super(player)
	subinstance.do_extras_when_landed(player)
	
func should_lose_on_enter(player):
	var curr_command = _inst.game_manager.current_command
	
	if (subtype == "balls" && curr_command is IFButton && curr_command.cond != curr_command.condList[1].cond):
		return true
	elif (subtype == "spikes" && curr_command is IFButton && curr_command.cond != curr_command.condList[0].cond):
		return true
	subinstance.come_from_if()
	return subinstance.should_lose_on_enter(player)
	
	
#AUX
func _get_spikes_sub_instance():
	if !subinstance:
		var randomN = randi() % 2
		var block = _block 
		var curr_command = _inst.game_manager.current_command
		
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
	if !subinstance:
		var randomN = randi() % 2
		var block = _block 
		var curr_command = _inst.game_manager.current_command
		
		block["amount"] = block.value
		
		if curr_command is IFButton:
			if !curr_command.is_right_true_branch():
				subinstance = BallBlock.new(block)
			else:
				if randomN == 0:
					subinstance = BallBlock.new(block)
				else:
					subinstance = MovementBlock.new(block)
		else:
			if curr_command is TakeButton:
				subinstance = MovementBlock.new(block)
			else:
				subinstance = BallBlock.new(block)

	return subinstance
