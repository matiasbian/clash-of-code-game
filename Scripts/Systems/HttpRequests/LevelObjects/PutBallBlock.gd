class_name PutBallBlock extends BaseGameBlock

var dir:MovementBlock.Directions
var balls = 0
const DISPLAYED_BALLS = 5

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
	
func should_lose_on_enter(player):
	#var curr_command = _inst.game_manager.current_command
	
	#if (from_if && curr_command is IFButton && curr_command.cond != curr_command.condList[1].cond):
	#	return true
	
	#return _inst._visible_balls() > 0 || super.should_lose_on_enter(player)
	return false
	
func should_lose_on_leave(player):
	return _inst._visible_balls() < DISPLAYED_BALLS
	
func do_extras_when_landed(player):
	super(player)
	var curr_command = _inst.game_manager.current_command
	
	if (!curr_command is PutButton):
		if (curr_command is IFButton && curr_command.true_branch.get_node("Button") is PutButton):
			_inst.putN(balls)
			_inst.landed_actions(player, self)
			return
		else:
			var condA = curr_command is ForButton && curr_command.iter.get_node("Button") is PutButton
			var condB = curr_command is ProcedureButton && curr_command.procedure.active_command is PutButton
			var condC = curr_command is ProcedureButton && curr_command.proc_picked.active_command is PutButton
			if ( condA || condB || condC):
				_inst.putN(balls)
				_inst.landed_actions(player, self)
			return
	
	_inst.putN(balls)
	_inst.landed_actions(player, self)
	
