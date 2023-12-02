class_name MovementBlock extends BaseGameBlock

enum Directions {NULL, Right, Left, Top, Bottom}

func shouldLose(player):
	var curr_command = _inst.game_manager.current_command
	
	#if (from_if):
	#	return true
	
	return super.shouldLose(player) || curr_command is TakeButton || (curr_command is ForButton && curr_command.iter.get_node("Button") is TakeButton)
