class_name FinishGameBlock extends GameBlock

@onready var treasure = get_node("Prize/AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.on_victory.connect(_win)
	pass # Replace with function body.
	
func _win(perc):
	get_node("/root/GlobalVar").play_win()
	treasure.play("Picked")

