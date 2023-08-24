extends CharacterBody2D

@export var speed = 400

#components
var anim

var target = Vector2(500,0)

func _ready():
	anim = get_node("AnimationPlayer")
	
func _input(event):
	if event.is_action_pressed("clicked"):
		print("clicked")
		movePlayerToPos(get_global_mouse_position())
		
func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	# look_at(target)
	_handlePlayerMovement()
		
func _handlePlayerMovement():
	if position.distance_to(target) > 5:
		move_and_slide()
	else:
		anim.stop()
		
func movePlayerToPos(pos):
	anim.play("Moving")
	target = pos


