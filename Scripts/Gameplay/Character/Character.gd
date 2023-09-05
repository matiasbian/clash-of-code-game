extends CharacterBody2D

@export var speed = 150
@onready var game_manager = get_node("/root/Node2D/Systems/GameManager")
signal movement_finished(pos)

#consts
const MOVE_ANIM = "Moving"
const IDLE_ANIM = "Idle"
const MOVEMENT_OFFSET_X = 130

#components
var anim

var target = Vector2(0,0)
var reachedPos = false
var die = false

func _ready():
	target = position
	anim = get_node("AnimationPlayer")
	game_manager.on_defeat.connect(on_defeat)
	game_manager.on_defeat_delay_needed.connect(on_defeat)

		
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
		if !die:
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
	
#events

func on_defeat():
	die = true
	anim.play("Die")
	


