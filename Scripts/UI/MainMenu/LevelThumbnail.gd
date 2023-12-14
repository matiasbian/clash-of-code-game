class_name UILevelTh extends Button

@onready var completed = get_node("Completado")
@onready var movements = get_node("Movimientos")
@onready var levelNumber = get_node("Nivel")
@onready var locked_icon = get_node("LockedIcon")

@export var stars_container:HBoxContainer = HBoxContainer.new()
var levelToLoad = 1

func _pressed():
	get_node("/root/GlobalVar").play_start_game()
	get_node("/root/GlobalVar").level = levelToLoad
	GlobalVar.tuto_completed = completed.visible
	
	get_node("/root/MainMenu/Music").stop()
	
	var par = get_parent()
	for elem in par.get_children():
		elem.disabled = true
	
	await get_tree().create_timer(1.5).timeout
	GlobalVar.prev_screen = GlobalVar.Screens.Menu
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	
func setData(progress):
	unlock()
	var data = progress
	if (stars_container):
		stars_container.get_parent().visible = true
		stars_container.setPerfectValues(data.movements, false)
	if (levelNumber):
		levelNumber.text = tr("LEVEL")  + "\n" + str(data.levelNumber)
		
	if (completed):
		completed.visible = true
	if (movements):
		stars_container.visible = true
	
func setLevel(data):
	levelToLoad = data.level
	
	if (levelNumber):
		levelNumber.text = tr("LEVEL")  + "\n" + str(data.level)
	
	if (data.level == 1):
		unlock()
	else:
		lock()
		
func unlock():
	disabled = false
	locked_icon.visible = false
	
func lock():
	disabled = true
	locked_icon.visible = true
		
func _ready():
	focus_mode = Control.FOCUS_NONE
		
