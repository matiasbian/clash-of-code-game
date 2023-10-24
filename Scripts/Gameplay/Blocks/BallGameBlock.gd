class_name BallGameBlock extends GameBlock

@onready var game_manager:Game_Manager = get_node("/root/Node2D/Systems/GameManager")

@export var balls_container:Node2D = Node2D.new()

var balls = 0

func before_land_actions(player, gameblock):
	super(player, gameblock)
	

func set_extra_data(step):
	balls = step.balls
	
	for i in range(0, balls):
		balls_container.get_child(i).visible = true
			
	super.set_extra_data(step)
	
func takeN(balls):
	print("bolas " + str(balls))
	
	if balls > _visible_balls():
		return false
	while balls > 0:
		_get_next_visible_ball().visible = false
		balls -= 1
	
		
func _visible_balls():
	var i = 0
	for ball in balls_container.get_children():
		if ball.visible:
			i += 1
	
	return i
	
func _get_next_visible_ball():
	for ball in balls_container.get_children():
		if ball.visible:
			return ball
	return null
		
	
