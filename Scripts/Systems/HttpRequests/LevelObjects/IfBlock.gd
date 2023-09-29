class_name IfBlock extends BaseGameBlock

var subinstance
	
func get_subinstance():
	if !subinstance:
		var randomN = randi() % 2
		var block = _block 
		var curr_command = _inst.game_manager.current_command
		
		curr_command
		
		if curr_command is IFButton:
			if randomN == 0:
				subinstance = MovementBlock.new(block)
			else:
				subinstance = JumpBlock.new(block)
		else:
			if curr_command is JumpButton:
				subinstance = MovementBlock.new(block)
			else:
				subinstance = JumpBlock.new(block)

	return subinstance

func do_extras_when_landed(player):
	super(player)
	subinstance.do_extras_when_landed(player)
	
func shouldLose(player):
	subinstance.come_from_if()
	return subinstance.shouldLose(player)

