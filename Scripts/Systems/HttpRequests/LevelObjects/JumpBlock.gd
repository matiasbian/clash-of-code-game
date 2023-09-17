class_name JumpBlock extends BaseGameBlock

var dir:MovementBlock.Directions

func _init(block):
	var direc:String = block["dir"]
	match direc:
		"Forward":
			dir = MovementBlock.Directions.Right
		"Back":
			dir = MovementBlock.Directions.Left
		"Top":
			dir = MovementBlock.Directions.Top
		"Bottom":
			dir = MovementBlock.Directions.Bottom
		_:
			dir = MovementBlock.Directions.Left
	print("Final dir: " + str(dir))
func shouldLose(player):
	
	return !player.is_jumping()
