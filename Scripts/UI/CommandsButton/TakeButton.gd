class_name TakeButton extends ActionButton

@export var take_pop_up:Control = Control.new()
var button:Button
var optionButton:OptionButton

func _ready():
	game_manager = get_node(GAME_MANAGER_PATH)
	game_manager.startedPlay.connect(_on_play)
	
	if !isSideMenu:
		return
		
	get_parent().get_node("Button/Label").visible = true
	button = take_pop_up.get_node("ColorRect/Btn")
	button.pressed.connect(_on_accept)
	optionButton = take_pop_up.get_node("ColorRect/VBoxContainer/HBoxContainer/OptionButton")
	
func _get_command_type():
	return self
	
func do_extras(player):
	super(player)
	#player._jump()
	
func _pressed():
	if logical_disable:
		return
		
	if (isSideMenu):
		take_pop_up.visible = true
	else:
		game_manager.RemoveCommand(index)
		
		
func _on_accept():
	take_pop_up.visible = false
	game_manager.AddCommand(_get_command_type())
	
func _get_dir(dir):
	if dir == 0:
		return MovementBlock.Directions.Right
	elif dir == 1:
		return MovementBlock.Directions.Left
	elif dir == 2:
		return MovementBlock.Directions.Top
	elif dir == 3:
		return MovementBlock.Directions.Bottom
		
		
func set_extra_values(original):
	pass
	
func get_classname():
	return "TakeButton class"
