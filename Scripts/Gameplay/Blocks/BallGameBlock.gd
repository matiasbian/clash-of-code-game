class_name BallGameBlock extends GameBlock

@export var balls_container:Node2D = Node2D.new()

var balls = 0

func before_land_actions(player, gameblock):
	super(player, gameblock)
	

func set_extra_data(step):
	balls = step.balls
	
	_init_balls(balls)
			
	super.set_extra_data(step)
	
func takeN(balls):
	if balls > _visible_balls():
		return false
	while balls > 0:
		_get_next_visible_ball().hide_ball(balls)
		balls -= 1
	
		
func _visible_balls():
	var i = 0
	for ball in balls_container.get_children():
		if ball.is_active():
			i += 1
	
	return i
	
func _get_next_visible_ball():
	for ball in balls_container.get_children():
		if ball.is_active():
			return ball
	return null
		
func _init_balls(amount):
	for i in range(0, amount):
		balls_container.get_child(i).show_ball(i)
