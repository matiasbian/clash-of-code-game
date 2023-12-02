class_name TutoScriptBase extends Node
@export var level:int = 0

@onready var game_manager:Game_Manager = get_node("/root/Node2D/Systems/GameManager")
signal go_next()

func _get_dialogs():
	return []
	
func mine():
	return self
	
func skip():
	get_node("/root/GlobalVar").play_tap()
	GlobalVar.tuto_skipped = true
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
