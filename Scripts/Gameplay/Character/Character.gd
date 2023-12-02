class_name Player extends CharacterBody2D

@export var speed = 150
@onready var game_manager:Game_Manager = get_node("/root/Node2D/Systems/GameManager")

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
var jump = false

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
		
func movePlayerToPos(pos, animate):
	anim.stop()	
	if (animate): 
		GlobalVar.play_step()
		anim.play("Moving")
	reachedPos = false
	target = pos
	
func movePlayerToDir(button):
	var offset = _get_movement_vector(button)
	var targetPos = position + offset
	var animate = !button is JumpButton
	movePlayerToPos(targetPos, animate)
	button.do_extras(self, targetPos)
	
func triggerMovementFinished():
	emit_signal("movement_finished", target)
	
func _get_movement_vector(button):
	var dir = button.get_dir()
	if (dir == MovementBlock.Directions.Right):
		return Vector2(MOVEMENT_OFFSET_X,0)
	elif (dir == MovementBlock.Directions.Left):
		return Vector2(-MOVEMENT_OFFSET_X,0)
	elif (dir == MovementBlock.Directions.Top):
		return Vector2(0, -MOVEMENT_OFFSET_X)
	elif (dir == MovementBlock.Directions.Bottom):
		return Vector2(0, MOVEMENT_OFFSET_X)
		
func _jump():
	anim.stop()
	jump = true
	anim.play("Jumping")
	get_node("/root/GlobalVar").play_jump()	

func is_jumping():
	return jump

func disable_jump():
	jump = false
	
func _get_current_block():
	return game_manager.get_block(target)
	
#events

func on_defeat():
	die = true
	anim.play("Die")
	
	await get_tree().create_timer(0.3).timeout
	get_node("/root/GlobalVar").play_explosion()
	
func _on_play():
	get_node("Arrow").visible = false
	


