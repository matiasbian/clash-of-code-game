class_name TimeManager extends Node

var time_lapsed:float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_lapsed += delta
	
func get_time_formatted():
	var seconds = floori(time_lapsed)%60
	var minutes = floori(time_lapsed/60)%60

	#returns a string with the format "MM:SS"
	return "%02d : %02d" % [minutes, seconds]
