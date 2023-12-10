class_name ActionButton extends Button

const GAME_MANAGER_PATH = "/root/Node2D/Systems/GameManager"

@export var isSideMenu:bool

@export var min_level_required:int = 1
@onready var unlocker:UnlockAtLevel = UnlockAtLevel.new(min_level_required, self)

@onready var baseColor:Color = modulate
@onready var procedure:Procedure = Procedure.new()

@onready var extra_info:Panel = get_node("ExtraInfo")

var game_manager:Game_Manager
var index
var logical_disable

func _ready():
	__ready()
	
func __ready():
	focus_mode =Control.FOCUS_NONE
	game_manager = get_node(GAME_MANAGER_PATH)
	game_manager.startedPlay.connect(_on_play)
	
	
func _pressed():
	if logical_disable:
		return

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

func do_extras(player):
	pass
	
func set_extra_values(original):
	pass
	
func _on_pop(val):
	pass
	
func pop_from_subqueue():
	var val = procedure.get_next_command()
	_on_pop(val)
	return val
	
func can_perform(data):
	return true
	
func get_perform_error(data):
	return ""
	
func get_classname():
	return "ActionButton abstract class"
	
func _show_label(text):
	get_parent().get_node("Button/Label").visible = true
	get_parent().get_node("Button/Label").text = text
	
func _get_label(dir):
	if dir == 1:
		return load("res://Art/Sprites/UI/resized/03_157559.png")
	elif dir == 2:
		return load("res://Art/Sprites/UI/resized/00_157559.png")
	elif dir == 3:
		return load("res://Art/Sprites/UI/resized/02_157559.png")
	elif dir == 4:
		return load("res://Art/Sprites/UI/resized/01_157559.png")
