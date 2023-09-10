class_name Player extends CharacterBody2D

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
	
	if (game_manager):
		game_manager.on_defeat.connect(on_defeat)
		game_manager.startedPlay.connect(_on_play)
		game_manager.on_defeat_delay_needed.connect(on_defeat)
	else:
		print("ERROR: Game manager not found in Player script")

		
func _physics_process(delta):
	velocity = position.direction_to(target) * speed
		
	# look_at(target)
	_handlePlayerMovement()
		
func _handlePlayerMovement():
	if position.distance_to(target) > 0.5:
		move_and_slide()
		get_node("Sprite2D").flip_h = velocity.x < 0
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

	var offset = _get_movement_vector(dir)
	var targetPos = position + offset
	movePlayerToPos(targetPos)
	
func triggerMovementFinished():
	emit_signal("movement_finished", target)
	
func _get_movement_vector(dir):
	if (dir == MovementBlock.Directions.Right):
		return Vector2(MOVEMENT_OFFSET_X,0)
	elif (dir == MovementBlock.Directions.Left):
		return Vector2(-MOVEMENT_OFFSET_X,0)
	elif (dir == MovementBlock.Directions.Top):
		return Vector2(0, -MOVEMENT_OFFSET_X)
	elif (dir == MovementBlock.Directions.Bottom):
		return Vector2(0, MOVEMENT_OFFSET_X)
	
#events

func on_defeat():
	die = true
	anim.play("Die")
	
func _on_play():
	get_node("Arrow").visible = false
	


