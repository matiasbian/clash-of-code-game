extends CharacterBody2D

@export var speed = 150
signal movement_finished(pos)

#consts
const MOVE_ANIM = "Moving"
const IDLE_ANIM = "Idle"
const MOVEMENT_OFFSET_X = 130

#components
var anim

var target = Vector2(0,0)
var reachedPos = false

func _ready():
	target = position
	anim = get_node("AnimationPlayer")
	
func _input(event):
	#if event.is_action_pressed("clicked"):
	#	movePlayerToPos(get_global_mouse_position())
	pass
		
func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	# look_at(target)
	_handlePlayerMovement()
		
func _handlePlayerMovement():
	if position.distance_to(target) > 0.5:
		move_and_slide()
	else:
		if reachedPos == false:
			reachedPos = true
			triggerMovementFinished()

		anim.play(IDLE_ANIM)
		
func movePlayerToPos(pos):
	anim.stop()	
	anim.play("Moving")
	reachedPos = false
	target = pos
	
func movePlayerToDir(dir):
	var offset = Vector2(MOVEMENT_OFFSET_X,0) if dir == 0 else Vector2(-MOVEMENT_OFFSET_X,0)
	var targetPos = position + offset
	movePlayerToPos(targetPos)
	
func triggerMovementFinished():
	emit_signal("movement_finished", target)
	


