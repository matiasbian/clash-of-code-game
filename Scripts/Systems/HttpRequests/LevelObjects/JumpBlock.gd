class_name JumpBlock extends BaseGameBlock

var dir:MovementBlock.Directions

func _init(block):
	var direc:String = block["direction"]
	match direc:
		"right":
			dir = MovementBlock.Directions.Right
		"left":
			dir = MovementBlock.Directions.Left
		"up":
			dir = MovementBlock.Directions.Top
		"down":
			dir = MovementBlock.Directions.Bottom
		_:
			dir = MovementBlock.Directions.Left
	pos = Vector2(block["positionX"], block["positionY"])
	
func shouldLose(player):
	emit_signal("before_check", null)
	return !player.is_jumping()
