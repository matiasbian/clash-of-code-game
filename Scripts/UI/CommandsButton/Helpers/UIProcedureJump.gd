class_name UIProcedureComplex extends UIProcedureMove

@export var pop_up = MarginContainer.new()
@export var pop_up_button_disa = Button.new()
@export var pop_up_button = Button.new()
@export var optionButton = OptionButton.new()
@export var label = Label.new()

var dir

func _pressed():
	if !picked:
		pop_up.visible = true
		pop_up_button_disa.visible = false
		pop_up_button.visible = true
		pop_up_button.pressed.connect(_save_command)
	else:
		print("indice " + str(get_index(true)))
		
		selected_container.remove_command(get_parent(), index)
	
func _save_command():
	pop_up.visible = false
	pop_up_button_disa.visible = true
	pop_up_button.visible = false
	
	_on_accept()
	label.text = _get_label(dir)
	label.visible = true
	selected_container.add_command(get_parent())
	
	
func _on_accept():
	dir = _get_dir(optionButton.get_selected_id())
	button_asocciated.get_node("Button").dir  = dir
	
	
func _get_dir(dir):
	if dir == 0:
		return MovementBlock.Directions.Right
	elif dir == 1:
		return MovementBlock.Directions.Left
	elif dir == 2:
		return MovementBlock.Directions.Top
	elif dir == 3:
		return MovementBlock.Directions.Bottom
		
func _get_label(dir):
	if dir == 1:
		return "->"
	elif dir == 2:
		return "<-"
	elif dir == 3:
		return "▲"
	elif dir == 4:
		return "▼"
	
