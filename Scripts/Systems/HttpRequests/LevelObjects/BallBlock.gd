class_name BallBlock extends BaseGameBlock

var dir:MovementBlock.Directions
var balls = 0

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
	balls = block.amount
	
func shouldLose(player):
	super.shouldLose(player)
	var curr_command = _inst.game_manager.current_command
	
	if (from_if && curr_command is IFButton && curr_command.cond != curr_command.condList[1].cond):
		return true
	
	return _inst._visible_balls() > 0 || super.shouldLose(player)
	
func do_extras_when_landed(player):
	super(player)
	
	var curr_command = _inst.game_manager.current_command
	
	if (!curr_command is TakeButton):
		if (curr_command is IFButton && curr_command.true_branch.get_node("Button") is TakeButton):
			_inst.takeN(balls)
			_inst.landed_actions(player, self)
			return
		else:
			var condA = curr_command is ForButton && curr_command.iter.get_node("Button") is TakeButton
			var condB = curr_command is ProcedureButton && curr_command.procedure.active_command is TakeButton
			var condC = curr_command is ProcedureButton && curr_command.proc_picked.active_command is TakeButton
			if ( condA || condB || condC):
				_inst.takeN(balls)
				_inst.landed_actions(player, self)
			return
	
	_inst.takeN(balls)
	_inst.landed_actions(player, self)
	
