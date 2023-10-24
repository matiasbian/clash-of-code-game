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
	print("Should lose")
	return _inst._visible_balls() > 0
	
func do_extras_when_landed(player):
	super(player)
	
	var curr_command = _inst.game_manager.current_command
	
	if (!curr_command is TakeButton):
		return
	
	_inst.takeN(curr_command.amount)
	_inst.landed_actions(player, self)
	
