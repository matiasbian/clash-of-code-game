class_name JumpButton extends ActionButton

@export var jump_pop_up:Control = Control.new()
var button:Button
var optionButton:OptionButton

func _ready():
	game_manager = get_node(GAME_MANAGER_PATH)
	game_manager.startedPlay.connect(_on_play)
	game_manager.jumps_updated.connect(jumps_updated)
	
	if !isSideMenu:
		get_parent().get_node("Button/Label").visible = true
		get_parent().get_node("Button/Label").text = _get_label(dir)
		return
		
	get_parent().get_node("Button/Label").visible = true
	button = jump_pop_up.get_node("ColorRect/Btn")
	button.pressed.connect(_on_accept)
	optionButton = jump_pop_up.get_node("ColorRect/HBoxContainer/OptionButton")
	
func _get_command_type():
	return self
	
func do_extras(player, targetPos):
	super(player, targetPos)
	player._jump()
	
func _pressed():
	if (isSideMenu):
		jump_pop_up.visible = true
		#game_manager.AddCommand(_get_command_type())
	else:
		game_manager.RemoveCommand(index)
		game_manager.add_jumps(1)
		
		
func _on_accept():
	jump_pop_up.visible = false
	dir = _get_dir(optionButton.get_selected_id())
	game_manager.AddCommand(_get_command_type())
	
func jumps_updated(jumps):
	if (isSideMenu):
		get_parent().get_node("Button/Label").text = str(jumps)
		disabled = jumps <= 0
	
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
	
