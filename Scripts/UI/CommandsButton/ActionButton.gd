class_name ActionButton extends Button

const GAME_MANAGER_PATH = "/root/Node2D/Systems/GameManager"
@export var dir = MovementBlock.Directions.NULL

@export var isSideMenu:bool
@onready var baseColor:Color = get_parent().color

var game_manager
var index

func _ready():
	focus_mode =Control.FOCUS_NONE
	game_manager = get_node(GAME_MANAGER_PATH)
	game_manager.startedPlay.connect(_on_play)
	
func _pressed():
	if (isSideMenu):
		game_manager.AddCommand(_get_command_type())
	else:
		get_node("/root/GlobalVar").play_audio_remove_button()
		game_manager.RemoveCommand(index)
		

func SetIndex(i):
	self.index = i

func _get_command_type():
	return null

func _elemFocused():
	get_parent().color = Color.AQUAMARINE
	
func _elemUnfocused():
	get_parent().color = baseColor
	
func _on_play():
	disabled = true
	
	if (!isSideMenu):
		return

	get_parent().color = Color.GRAY

func do_extras(player):
	pass
