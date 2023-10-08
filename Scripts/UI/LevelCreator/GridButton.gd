class_name EventButton
extends Button

signal left_click
signal right_click

@export var mov_icon:Texture = Texture.new()
@export var start_icon:Texture = Texture.new()
@export var end_icon:Texture = Texture.new()
@export var jump_icon:Texture = Texture.new()
@export var if_icon:Texture = Texture.new()

var types = ["", "Sta", "Fin", "Mov", "Ju", "IF"]
@onready var types_icon = [null, start_icon, end_icon, mov_icon, jump_icon, if_icon]
var colors = [Color.GRAY, Color.YELLOW, Color.YELLOW, Color.YELLOW_GREEN, Color.TOMATO, Color.DARK_GOLDENROD]
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
	#text = types[i]
	get_node("icon").texture = types_icon[i]
	modulate = colors[i]
	_update_data()

func _update_data():
	if i == 0:
		container.remove_if(self)
	else:
		container.update_or_add(self)
		
func getType():
	return types[i]
	
