extends Sprite2D

var visible_state = false
var init_wait

@export var sprite_ball = Sprite2D.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(init_wait * 0.21).timeout
	get_node("TakeBalls").play("Idle")

	
func show_ball(wait):
	visible_state = true
	sprite_ball.visible = true
	init_wait = wait

	
	
func hide_ball(wait):
	visible_state = false
	await get_tree().create_timer(wait * 0.1).timeout
	get_node("TakeBalls").play("Take")
	GlobalVar.play_commands()

func is_active():
	return visible_state
