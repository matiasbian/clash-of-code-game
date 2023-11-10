extends Camera2D

var target_zoom_out = Vector2(0.45, 0.45)
var target_pos
var initial_pos

var t = 0.0
var zoom_in = false
var move = false
var can_zoom = true

@onready var game_manager:Game_Manager = get_node("/root/Node2D/Systems/GameManager")

# Called when the node enters the scene tree for the first time.
func _ready():
	target_pos = position + Vector2(0,-150)
	initial_pos = position
	game_manager.startedPlay.connect(_on_play)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!move):
		return
		
	var target
	var pos
	
	if zoom_in:
		target = target_zoom_out
		pos = target_pos
	else:
		target = Vector2.ONE * 1.6
		pos = initial_pos
		
	t = delta * 5
	zoom = zoom.lerp(target, t)
	position = position.lerp(pos, t)
	
	if (position.distance_to(pos) < 0.3 && zoom.distance_to(target) < 0.3):
		move = false
	
func _input(event):
	if event.is_action_pressed("map") && can_zoom:
		zoom_in = !zoom_in
		move = true
		
func _on_play():
	can_zoom = false
	move = true
	zoom_in = false
	
