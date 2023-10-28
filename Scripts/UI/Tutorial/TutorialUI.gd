extends Panel

var dialog_list = []

@export var scripts:Node = Node.new()

var current_step

@export var dialog_label:Label = Label.new()
@export var overlay:Button = Button.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	overlay.focus_mode = Control.FOCUS_NONE
	overlay.pressed.connect(_on_Button_gui_input)
	dialog_list = scripts.get_child(GlobalVar.level -1)._get_dialogs()
	go_next()
	
func _next_step():
	if dialog_list.is_empty():
		return null
	
	return dialog_list.pop_front()
		

func go_next():
	if dialog_list.is_empty():
		visible = false
		return
	
	current_step = _next_step()
	dialog_label.text = current_step.dialog

func _on_Button_gui_input():
	go_next()
