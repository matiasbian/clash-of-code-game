class_name UILevelStructure extends Node

@export var levelNumber:SpinBox = SpinBox.new()
@export var level_label:TextEdit = TextEdit.new()
@export var dialog:TextEdit = TextEdit.new()
@export var min_steps:SpinBox = SpinBox.new()

@export var dropdown:OptionButton = OptionButton.new()
@export var add_button:Button = Button.new()
@export var submit_button:Button = Button.new()
@export var cancel_button:Button = Button.new()

@export var grid:GridButtonSpawner = GridButtonSpawner.new()

@export var success_popup:Panel = Panel.new()
@export var failure_popup:Panel = Panel.new()
@export var failure_label_popup:Label = Label.new()

@export var http_req:HTTP_REQUESTS = HTTP_REQUESTS.new()

@export var ok_color:Color = Color.WHITE
@export var error_color:Color = Color.FIREBRICK

@onready var dic:Dictionary
var itemSelectedIndex:int
var min_steps_value:int
var level_number_value:int
var steps = []

const URL = "http://localhost:3000/api/levels"
const ALREADY_EXISTS_TEXT = "Ya existe el nivel que se intenta crear"
const ERROR_TEXT = "Error al guardar el nivel.\nRevise los campos en rojo"



# Called when the node enters the scene tree for the first time.
func _ready():
	dropdown.item_selected.connect(_item_selected)
	itemSelectedIndex = dropdown.get_item_id(0)	
	
	add_button.pressed.connect(_resize_grid)
	
	submit_button.pressed.connect(_submit)
	cancel_button.pressed.connect(_cancel)
	levelNumber.value_changed.connect(_level_changed)
	min_steps.value_changed.connect(_min_steps_changed)
	
	http_req.data_sent.connect(_open_success_popup)	
	
	success_popup.get_node("Container/Button").pressed.connect(_close_s)
	failure_popup.get_node("Container/Button").pressed.connect(_close_f)
	
	_fill_dic()
	
func _item_selected(index):
	itemSelectedIndex = dropdown.get_item_id(index)

func _resize_grid():
	get_node("/root/GlobalVar").play_tap()
	grid.resize(itemSelectedIndex)
	_reset()
	
func _submit():
	var structure = _level_structure()	
	var error = _check_errors(structure)
	
	if (!error):
		get_node("/root/GlobalVar").play_tap()
		http_req.HTTPPost(URL, structure)
	else:
		failure_label_popup.text = ERROR_TEXT
		failure_popup.visible = true
		
func _cancel():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")	

func _open_success_popup(data, r_code):
	if (r_code < 400):
		success_popup.visible = true
	else:
		failure_label_popup.text = ALREADY_EXISTS_TEXT
		failure_popup.visible = true

func _level_changed(value):
	level_number_value = value

func _min_steps_changed(value):
	min_steps_value = value
	
func _close_s():
	get_node("/root/GlobalVar").play_tap()
	success_popup.visible = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	
func _close_f():
	get_node("/root/GlobalVar").play_tap()
	failure_popup.visible = false	
# aux

func _level_structure():
	return {
		"levelNumber": level_number_value,
		"label": level_label.get_line(0),
		"dialogs": dialog.get_line(0),
		"perfect_steps": min_steps_value,
		"structure": {
			"elements": steps
		}
	}

func _fill_dic():
	#movement
	dic["Mov"] = {
		"positionX": 0,
		"positionY": 0,
		"type": "movement",
	}
	
	dic["Ju"] = {
		"positionX": 0,
		"positionY": 0,
		"type": "jump",
		"direction": "up"
	}
	
	dic["Sta"] = {
		"positionX": 0,
		"positionY": 0,
		"type": "start",
	}
	
	dic["Fin"] = {
		"positionX": 0,
		"positionY": 0,
		"type": "finish",
	}
	
	dic["IF"] = {
		"positionX": 0,
		"positionY": 0,
		"type": "if",
		"subtype": "spikes",
		"value": 0
	}
	
	dic["IFB"] = {
		"positionX": 0,
		"positionY": 0,
		"type": "if",
		"subtype": "balls",
		"value": 5
	}
	
	dic["Ball"] = {
		"positionX": 0,
		"positionY": 0,
		"type": "ball",
		"amount":5
	}
	
	dic["PutBall"] = {
		"positionX": 0,
		"positionY": 0,
		"type": "putball",
		"amount":5
	}
	
func add_step(type, pos):
	var step = dic[type]
	step.positionX = pos.x
	step.positionY = pos.y
	steps.push_back(step)


func _check_errors(structure):
	var error = false
	#check label
	if structure["label"] == "":
		level_label.get_parent().get_node("Label").add_theme_color_override("font_color", error_color)
		error = true
	else:
		level_label.get_parent().get_node("Label").add_theme_color_override("font_color", ok_color)
		
	#check lvl number
	if structure["levelNumber"] == 0:
		levelNumber.get_parent().get_node("Label").add_theme_color_override("font_color", error_color)
		error = true
	else:
		levelNumber.get_parent().get_node("Label").add_theme_color_override("font_color", ok_color)
		
	#check steps amount
	if structure["perfect_steps"] == 0:
		min_steps.get_parent().get_node("Label").add_theme_color_override("font_color", error_color)
		error = true
	else:
		min_steps.get_parent().get_node("Label").add_theme_color_override("font_color", ok_color)

	#structure
	var hasStart
	var hasEnd
	var localError
	for s in steps:
		hasStart = s.type == "start" || hasStart
		hasEnd = s.type == "finish" || hasEnd
		
	localError = !hasStart || !hasEnd
	
	if (localError):
		dropdown.get_parent().get_node("Label").add_theme_color_override("font_color", error_color)
		error = true
	else:
		dropdown.get_parent().get_node("Label").add_theme_color_override("font_color", ok_color)
		
	return error
	
func _reset():
	steps = []
	
func remove_if(button):
	var elem = -1
	for index in range(0, steps.size()):
		if button.grid_pos.x == steps[index].positionX && button.grid_pos.y == steps[index].positionY:
			elem = index
	
	if elem > 0:
		steps.remove_at(elem)
		
func update_or_add(button):
	var elem = -1
	
	for index in range(0, steps.size()):
		if button.grid_pos.x == steps[index].positionX && button.grid_pos.y == steps[index].positionY:
			elem = index
			
	var toAdd = dic[button.getType()].duplicate()
	toAdd.positionX = button.grid_pos.x
	toAdd.positionY = button.grid_pos.y
	
	if elem >= 0:
		steps[elem] = toAdd
	else:
		steps.push_back(toAdd)
		
	
