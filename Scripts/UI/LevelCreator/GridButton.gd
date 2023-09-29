class_name EventButton
extends Button

signal left_click
signal right_click

var types = ["", "Sta", "Fin", "Mov", "Ju"]
var colors = [Color.GRAY, Color.BROWN, Color.CORNFLOWER_BLUE, Color.YELLOW_GREEN, Color.TOMATO, Color.TOMATO, Color.TOMATO, Color.TOMATO]
var i = 0

var grid_pos

@onready var container = get_parent().get_parent().get_parent()

func _ready():
# warning-ignore:return_value_discarded
	connect("gui_input", _on_Button_gui_input)
	
func set_pos(pos):
	grid_pos = pos

func _on_Button_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			1:
				_change_type()
			2:
				_reset()
	

func _change_type():
	get_node("/root/GlobalVar").play_tap()
	if (i >= types.size() -1):
		i = 0
	else:
		i+=1
	_update_button()
	
func _reset():
	get_node("/root/GlobalVar").play_tap()
	i = 0
	_update_button()
	
func _update_button():
	text = types[i]
	modulate = colors[i]
	_update_data()

func _update_data():
	if i == 0:
		container.remove_if(self)
	else:
		container.update_or_add(self)
		
func getType():
	return types[i]
	
