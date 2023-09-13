class_name UILevelStructure extends Node

@export var dropdown:OptionButton = OptionButton.new()
@export var itemList:ItemList = ItemList.new()
@export var levelNumber:SpinBox = SpinBox.new()
@export var level_label:TextEdit = TextEdit.new()
@export var min_steps:SpinBox = SpinBox.new()

@export var add_button:Button = Button.new()
@export var submit_button:Button = Button.new()
@export var http_req:HTTP_REQUESTS = HTTP_REQUESTS.new()

@onready var dic:Dictionary
var itemSelectedIndex:int
var min_steps_value:int
var level_number_value:int
var steps = []

const URL = "http://localhost:3000/api/levels"


# Called when the node enters the scene tree for the first time.
func _ready():
	itemList.item_selected.connect(_delete_item)
	dropdown.item_selected.connect(_item_selected)
	add_button.pressed.connect(_item_added)
	submit_button.pressed.connect(_submit)
	levelNumber.value_changed.connect(_level_changed)
	min_steps.value_changed.connect(_min_steps_changed)
	_fill_dic()

func _delete_item(index):
	print("Deleting item")
	itemList.remove_item(index)
	steps.remove_at(index)
	print(steps)
	
func _item_selected(index):
	print("item selected Index  " + str(index))
	itemSelectedIndex = index
	
func _item_added():
	print("adding item")
	var itemAdded = dropdown.get_item_text(itemSelectedIndex)
	var itemID = dropdown.get_item_id(itemSelectedIndex)
	itemList.add_item(itemAdded)
	steps.push_back(dic[itemID])
	print(steps)
	
func _submit():
	var structure = _level_structure()
	var error = false
	#check label
	if structure["label"] == "":
		print("label is empty")
		error = true
	#check lvl number
	if structure["levelNumber"] == 0:
		print("level number cannot be 0")
		error = true
	#check steps amount
	if structure["perfect_steps"] == 0:
		print("perfect steps cannot be 0")
		error = true

	if (steps.size() > 0):
		# check structure
		var start_step:Dictionary = steps[0]
		var end_step:Dictionary = steps[steps.size() -1]
		
		
		if !(start_step.keys()[0] == dic[7].keys()[0] && end_step.keys()[0] == dic[8].keys()[0]):
			error = true
	else:
		error = true
	
	if (!error):
		print("sending data")
		http_req.HTTPPost(URL, structure)
	
func _level_changed(value):
	level_number_value = value

func _min_steps_changed(value):
	min_steps_value = value
# aux

func _level_structure():
	return {
		"levelNumber": level_number_value,
		"label": level_label.get_line(0),
		"perfect_steps": min_steps_value,
		"structure": {
			"elements": steps
		}
	}

func _fill_dic():
	dic[0] = {
		"movement": {
			"dir": "Forward"
		}
	}
	
	dic[1] = {
		"movement": {
			"dir": "Backward"
		}
	}
	
	dic[2] = {
		"movement": {
			"dir": "Top"
		}
	}
	
	dic[3] = {
		"movement": {
			"dir": "Bottom"
		}
	}
	
	dic[7] = {
			"start": {}
	}
	
	dic[8] = {
		"finish": {
			"dir": "Forward"
		}
	}
	
