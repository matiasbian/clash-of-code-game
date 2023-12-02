class_name GameBlock extends Node

@onready var game_manager:Game_Manager = get_node("/root/Node2D/Systems/GameManager")
var step_class
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func before_land_actions(player, gameblock):
	pass

func landed_actions(player, gameblock):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func init(dir):
	step_class = dir
	
func set_extra_data(step):
	pass
