extends Button

@onready var MainMenu = get_node("/root/MainMenu/UI/MainMenu")
@onready var LevelsMenu = get_node("/root/MainMenu/UI/Levels")

@export var levelEditButton:Button = Button.new()

var i18n = TextTo18n.new("PLAY", self)

func _pressed():
	get_node("/root/GlobalVar").play_tap()
	MainMenu.visible = false
	LevelsMenu.visible = true
	
	
	
func _ready():
	levelEditButton.pressed.connect(_edit_level_pressed)
	
	var buttons = get_parent().get_children()
	
	for b in buttons:
		b.focus_mode =Control.FOCUS_NONE
	
func _edit_level_pressed():
	get_node("/root/GlobalVar").play_start_game()
	
	get_node("/root/MainMenu/Music").stop()
	
	var par = get_parent()
	for elem in par.get_children():
		elem.disabled = true
	
	await get_tree().create_timer(1.7).timeout
	get_tree().change_scene_to_file("res://Scenes/LevelEditor.tscn")


