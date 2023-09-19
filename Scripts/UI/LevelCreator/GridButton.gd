class_name EventButton
extends Button

signal left_click
signal right_click

var types = ["", "Mov", "Jump", "Start", "Finish"]
var colors = [Color.GRAY, Color.BROWN, Color.CORNFLOWER_BLUE, Color.YELLOW_GREEN, Color.TOMATO]
var i = 0

func _ready():
# warning-ignore:return_value_discarded
	connect("gui_input", _on_Button_gui_input)

func _on_Button_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			1:
				_change_type()
			2:
				_reset()
	

func _change_type():
	if (i >= types.size() -1):
		i = 0
	else:
		i+=1
	_update_button()
	
func _reset():
	i = 0
	_update_button()
	
func _update_button():
	text = types[i]
	modulate = colors[i]
