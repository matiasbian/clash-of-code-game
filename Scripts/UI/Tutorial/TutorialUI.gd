class_name TutorialUI extends Panel

var dialog_list = []
var current_script:TutoScriptBase

@export var scripts:Node = Node.new()
@export var hardcoded_level = false

var current_step
var has_tuto

@export var dialog_label:Label = Label.new()
@export var overlay:Button = Button.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	if hardcoded_level && StoredData.load("TutoLevelEditor"):
		visible = false
		return
	elif (GlobalVar.tuto_completed || (!hardcoded_level && GlobalVar.level > scripts.get_child_count())):
		visible = false
		return
		
	has_tuto = true
	
	overlay.focus_mode = Control.FOCUS_NONE
	overlay.pressed.connect(_on_Button_gui_input)
	if hardcoded_level:
		current_script = scripts.get_child(0)
	else:
		current_script = scripts.get_child(GlobalVar.level -1)
	current_script.go_next.connect(go_next)
	
	dialog_list = current_script._get_dialogs()
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
	
	if current_step.has("action"):
		if (current_step.has("param")):
			current_step.action.call(current_step.param)
		else:
			current_step.action.call()

func _on_Button_gui_input():
	go_next()

