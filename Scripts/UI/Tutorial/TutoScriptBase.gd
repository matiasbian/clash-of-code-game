class_name TutoScriptBase extends Node

@onready var game_manager:Game_Manager = get_node("/root/Node2D/Systems/GameManager")
signal go_next()

func _get_dialogs():
	return []
