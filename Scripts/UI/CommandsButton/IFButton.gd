class_name IFButton extends ActionButton

func _get_command_type():
	return self
	
func do_extras(player):
	player.disable_jump()
	
