class_name UILevelTh extends Button

@onready var completed = get_node("Completado")
@onready var movements = get_node("Movimientos")
@onready var levelNumber = get_node("Nivel")
var levelToLoad = 1

func _pressed():
	get_node("/root/GlobalVar").play_start_game()
	get_node("/root/GlobalVar").level = levelToLoad
	
	get_node("/root/MainMenu/Music").stop()
	
	var par = get_parent()
	for elem in par.get_children():
		elem.disabled = true
	
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	
func setData(progress):
	var data = progress
	if (movements):
		movements.text = "Movimientos: " + str(data.movements)
	if (levelNumber):
		levelNumber.text = "Nivel\n " + str(data.levelNumber)
		
	if (completed):
		completed.visible = true
	if (movements):
		movements.visible = true
	
func setLevel(data):
	levelToLoad = data.level
	
	if (levelNumber):
		levelNumber.text = "Nivel\n " + str(data.level)
		
