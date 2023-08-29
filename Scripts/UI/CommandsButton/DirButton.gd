extends ActionButton

@export var dir:MovementBlock.Directions = MovementBlock.Directions.Left

func _get_command_type():
	return self
