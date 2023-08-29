class_name ActionButton extends Button

const GAME_MANAGER_PATH = "/root/Node2D/Systems/GameManager"

@export var isSideMenu:bool

var game_manager
var index

func _ready():
	game_manager = get_node(GAME_MANAGER_PATH)
	
func _pressed():
	if (isSideMenu):
		game_manager.AddCommand(_get_command_type())
	else:
		game_manager.RemoveCommand(index)

func SetIndex(i):
	self.index = i

func _get_command_type():
	return null
	
