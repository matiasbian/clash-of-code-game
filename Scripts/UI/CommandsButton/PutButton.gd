class_name PutButton extends ActionButton

func _ready():
	game_manager = get_node(GAME_MANAGER_PATH)
	game_manager.startedPlay.connect(_on_play)
	
	if !isSideMenu:
		return
		
	
func _get_command_type():
	return self
	
func do_extras(player):
	super(player)
	#player._jump()
		
		
func set_extra_values(original):
	pass
	
func get_classname():
	return "PutButton class"
