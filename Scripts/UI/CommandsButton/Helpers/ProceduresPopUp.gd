class_name ProceduresPopup extends Panel

@export var item_list:ProcedureItemList = ProcedureItemList.new()

@export var confirm_button:Button = Button.new()
@export var cancel_button:Button = Button.new()
@export var open_popup_button:Button = Button.new()

@onready var game_manager:Game_Manager = get_node("/root/Node2D/Systems/GameManager")

@export var min_level_required:int = 1
@onready var unlocker:UnlockAtLevel = UnlockAtLevel.new(min_level_required, open_popup_button.get_parent(), false)
# Called when the node enters the scene tree for the first time.
func _ready():
	confirm_button.pressed.connect(_add_proc)
	cancel_button.pressed.connect(close)
	open_popup_button.pressed.connect(open)
	

	
func open():
	visible = true
	item_list.refresh_list()

func close():
	visible = false
	
func _add_proc():
	game_manager.AddCommand(item_list.selected_proc)
	close()
