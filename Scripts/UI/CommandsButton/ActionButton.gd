class_name ActionButton extends Button

const GAME_MANAGER_PATH = "/root/Node2D/Systems/GameManager"
@export var dir = MovementBlock.Directions.NULL

@export var isSideMenu:bool

@onready var baseColor:Color = modulate


var game_manager:Game_Manager
var index

func _ready():
	__ready()
	
func __ready():
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
	grab_focus()
	modulate = Color("00ced0")
	
func _elemUnfocused():
	modulate = baseColor
	
func _on_play():
	disabled = true
	
	if (!isSideMenu):
		return

	get_parent().color = Color.GRAY

func do_extras(player, targetPos):
	if game_manager.get_block(targetPos):
		game_manager.get_block(targetPos).going_to_this_block(player)
	pass
	
func get_dir():
	return dir
	
func set_extra_values(original):
	pass
