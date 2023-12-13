class_name MovementBlock extends BaseGameBlock

enum Directions {NULL, Right, Left, Top, Bottom}

func should_lose_on_enter(player):
	var curr_command = _inst.game_manager.current_command
	
	#if (from_if):
	#	return true
	
	return super.should_lose_on_enter(player) || curr_command is TakeButton || (curr_command is ForButton && curr_command.iter.get_node("Button") is TakeButton)
