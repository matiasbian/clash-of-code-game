class_name UILevelTh extends Button

@onready var completed = get_node("Completado")
@onready var movements = get_node("Movimientos")
@onready var levelNumber = get_node("Nivel")

func _pressed():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	
func setData(progress):
	var data = progress
	movements.text = "Movimientos: " + str(data.movements)
	levelNumber.text = "Nivel\n " + str(data.levelNumber)
		
	completed.visible = progress.size() > 0
	movements.visible = progress.size() > 0
		
