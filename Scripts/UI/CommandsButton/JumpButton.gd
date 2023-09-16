class_name JumpButton extends ActionButton

func _get_command_type():
	return self
	
func do_extras(player):
	print("Jumping")
	player._jump()
