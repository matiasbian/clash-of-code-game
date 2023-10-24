class_name TakeButton extends ActionButton

@export var take_pop_up:Control = Control.new()
@export var spin_box:SpinBox = SpinBox.new()
var button:Button
var optionButton:OptionButton
var amount

func _ready():
	game_manager = get_node(GAME_MANAGER_PATH)
	game_manager.startedPlay.connect(_on_play)
	
	if !isSideMenu:
		get_parent().get_node("Button/Label").visible = true
		get_parent().get_node("Button/Label").text = _get_label(dir)
		return
		
	get_parent().get_node("Button/Label").visible = true
	button = take_pop_up.get_node("ColorRect/Btn")
	button.pressed.connect(_on_accept)
	optionButton = take_pop_up.get_node("ColorRect/VBoxContainer/HBoxContainer/OptionButton")
	
func _get_command_type():
	return self
	
func do_extras(player, targetPos):
	super(player, targetPos)
	#player._jump()
	
func _pressed():
	if (isSideMenu):
		take_pop_up.visible = true
	else:
		game_manager.RemoveCommand(index)
		
		
func _on_accept():
	take_pop_up.visible = false
	dir = _get_dir(optionButton.get_selected_id())
	amount = spin_box.value
	game_manager.AddCommand(_get_command_type())
	print("Valuardo " + str(amount))
	
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
		
func set_extra_values(original):
	amount = original.amount
	print("Desired amount " + str(amount) + " - " +  str(original.amount))
	
