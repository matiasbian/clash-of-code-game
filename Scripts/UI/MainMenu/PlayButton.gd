extends Button

@onready var MainMenu = get_node("/root/MainMenu/UI/MainMenu")
@onready var LevelsMenu = get_node("/root/MainMenu/UI/Levels")

func _pressed():
	MainMenu.visible = false
	LevelsMenu.visible = true


