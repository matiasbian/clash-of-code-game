extends Button

@onready var completed = get_node("Completado")
@onready var movements = get_node("Movimientos")

func _pressed():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	
func setData(progress):
	if (progress.size() > 0):
		var data = progress[0]
		movements.text = "Movimientos: " + str(data.movements)
		
	completed.visible = progress.size() > 0
	movements.visible = progress.size() > 0
		
	
