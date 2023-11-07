class_name DirButton extends ActionButton
		
func _get_command_type():
	return self
	
func do_extras(player, targetPos):
	super(player, targetPos)	
	player.disable_jump()
	
func get_classname():
	return "DirButton class" + str(dir)
