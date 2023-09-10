extends ActionButton

@export var dir:MovementBlock.Directions = MovementBlock.Directions.Top
	
func _get_command_type():
	return self

