class_name JumpBlock extends BaseGameBlock

var dir:MovementBlock.Directions

func _init(block):
	if (block.has("direction")):
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
	
	var curr_command = _inst.game_manager.current_command
	if (from_if && curr_command is IFButton && curr_command.cond != curr_command.condList[0].cond):
		return true
		
	return !player.is_jumping()
	
func do_extras_when_landed(player):
	super(player)
	_inst.landed_actions(player, self)
	
