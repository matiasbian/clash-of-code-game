class_name PutBallGameBlock extends BallGameBlock

@export var balls_placeholder:Node2D = Node2D.new()

func _init_balls(amount):
	for i in range(0, amount):
		balls_container.get_child(i).hide_ball_init(i)

func putN(balls):
	var i = 0
	while i < balls:
		_get_next_hidden_ball().show_balls(i)
		balls_placeholder.get_child(i).visible = false
		i += 1
