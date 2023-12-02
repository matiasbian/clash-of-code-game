class_name UIProcedureComplex extends UIProcedureMove

@export var pop_up = MarginContainer.new()
@export var pop_up_button_disa = Button.new()
@export var pop_up_button = Button.new()
@export var optionButton = OptionButton.new()
@export var arrow = TextureRect.new()

var dir

func _pressed():
	if !picked:
		pop_up.visible = true
		pop_up_button_disa.visible = false
		pop_up_button.visible = true
		pop_up_button.pressed.connect(_save_command)
	else:
		selected_container.remove_command(get_parent(), index)
	
func _save_command():
	pop_up.visible = false
	pop_up_button_disa.visible = true
	pop_up_button.visible = false
	
	_on_accept()
	arrow.texture = _get_label(dir)
	arrow.visible = true
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
		return load("res://Art/Sprites/UI/resized/03_157559.png")
	elif dir == 2:
		return load("res://Art/Sprites/UI/resized/00_157559.png")
	elif dir == 3:
		return load("res://Art/Sprites/UI/resized/02_157559.png")
	elif dir == 4:
		return load("res://Art/Sprites/UI/resized/01_157559.png")
	
