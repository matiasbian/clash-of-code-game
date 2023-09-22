extends Button

@onready var MainMenu = get_node("/root/MainMenu/UI/MainMenu")
@onready var LevelsMenu = get_node("/root/MainMenu/UI/Levels")

@export var levelEditButton:Button = Button.new()
func _pressed():
	get_node("/root/GlobalVar").play_tap()
	MainMenu.visible = false
	LevelsMenu.visible = true
	
func _ready():
	levelEditButton.pressed.connect(_edit_level_pressed)
	
func _edit_level_pressed():
	get_node("/root/GlobalVar").play_tap()
	get_tree().change_scene_to_file("res://Scenes/LevelEditor.tscn")


