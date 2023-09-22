extends Button

const GAME_MANAGER_PATH = "/root/Node2D/Systems/GameManager"

var game_manager
# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager = get_node(GAME_MANAGER_PATH)

func _pressed():
	get_node("/root/GlobalVar").play_tap()
	var played = game_manager.PlayCommands()
	disabled = played

