class_name JumpButton extends ActionButton

@export var jump_pop_up:Control = Control.new()
var button:Button
var optionButton:OptionButton

func _ready():
	game_manager = get_node(GAME_MANAGER_PATH)
	game_manager.startedPlay.connect(_on_play)
	game_manager.jumps_updated.connect(jumps_updated)
	
	if !isSideMenu:
		return
		
	button = jump_pop_up.get_node("ColorRect/Btn")
	button.pressed.connect(_on_accept)
	optionButton = jump_pop_up.get_node("ColorRect/HBoxContainer/OptionButton")
	
func _get_command_type():
	return self
	
func do_extras(player, targetPos):
	super(player, targetPos)
	player._jump()
	
func _pressed():
	if logical_disable:
		return
		
	if (isSideMenu):
		jump_pop_up.visible = true
		#game_manager.AddCommand(_get_command_type())
	else:
		game_manager.RemoveCommand(index)
		game_manager.add_jumps(1)
		
		
func _on_accept():
	jump_pop_up.visible = false
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
		
func can_perform(jumps = 1):
	return game_manager.jumps_availables >= jumps
	
func get_perform_error(data):
	return "Quedan %d saltos disponibles.\nSe intento agregar %d saltos" % [game_manager.jumps_availables, data]
	
func get_classname():
	return "JumpButton class"
