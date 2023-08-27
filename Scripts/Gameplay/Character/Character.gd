extends CharacterBody2D

@export var speed = 150

#consts
const MOVE_ANIM = "Moving"
const IDLE_ANIM = "Idle"

#components
var anim

var target = Vector2(0,0)

func _ready():
	target = position
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
		anim.play(IDLE_ANIM)
		
func movePlayerToPos(pos):
	anim.stop()	
	anim.play("Moving")
	target = pos


