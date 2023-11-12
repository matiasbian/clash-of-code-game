extends Button

func _ready():
	focus_mode =Control.FOCUS_NONE

func _pressed():
	GlobalVar.prev_screen = GlobalVar.Screens.Game
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
