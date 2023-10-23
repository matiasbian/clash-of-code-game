extends Button

func _ready():
	focus_mode =Control.FOCUS_NONE

func _pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
