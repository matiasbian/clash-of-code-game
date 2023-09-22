class_name UILevelTh extends Button

@onready var completed = get_node("Completado")
@onready var movements = get_node("Movimientos")
@onready var levelNumber = get_node("Nivel")
var levelToLoad = 1

func _pressed():
	get_node("/root/GlobalVar").level = levelToLoad
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	
func setData(progress):
	print(progress.movements)
	var data = progress
	movements.text = "Movimientos: " + str(data.movements)
	levelNumber.text = "Nivel\n " + str(data.levelNumber)
		
	completed.visible = true
	movements.visible = true
	
func setLevel(data):
	levelToLoad = data.level
	levelNumber.text = "Nivel\n " + str(data.level)
		
