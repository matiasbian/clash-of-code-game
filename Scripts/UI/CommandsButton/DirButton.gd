class_name DirButton extends ActionButton

@export var dir = MovementBlock.Directions.NULL

func _get_command_type():
	return self
	
func do_extras(player:Player):
	super(player)	
	
	player.move_player(get_dir())
	player.disable_jump()
	
func get_classname():
	return "DirButton class" + str(dir)
	
func get_dir():
	return dir
