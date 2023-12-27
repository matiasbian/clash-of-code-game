extends TutoLevelTwo

@export var act_overlay:Panel = Panel.new()
@export var amount_overlay:Panel = Panel.new()
@export var am_spinbox:SpinBox = SpinBox.new()

func _get_dialogs():
	return [
		{
			"dialog": "TUTORIAL_05_00"
		},
		{
			"dialog": "TUTORIAL_05_01"
		},
		{
			"dialog": "TUTORIAL_05_02"
		},
		{
			"dialog": 'TUTORIAL_05_03',
			"action": _show_jump
		},
		{
			"dialog": 'TUTORIAL_05_04',
			"action": show_overlay_generic,
			"param": act_overlay
		},
		{
			"dialog": 'TUTORIAL_05_05'
		},
		{
			"dialog": 'TUTORIAL_05_06',
			"action": show_spin
		},
		{
			"dialog": 'TUTORIAL_05_07'
		},
		{
			"dialog": 'TUTORIAL_05_08',
			"action": enable_repeat
		},
		{
			"dialog": 'TUTORIAL_05_09',
			"action": _show_accept,
			"param": amount_overlay
		},
		{
			"dialog": "TUTORIAL_05_10",
			"action": show_arrow
		},
		{
			"dialog": 'TUTORIAL_05_11',
			"action": show_forward,
			"param": 3
		},
		{
			"dialog": 'TUTORIAL_05_12'
		},
		{
			"dialog": "TUTORIAL_05_13"
		},
	]

func _show_jump():
	show_avaialable_commands("For")
	jump_button.pressed.connect(go)
	go_button_ov.pressed.connect(go)
	jump_child = 9

func show_forward(index = 0):
	to_deanim_elem = "Top"
	super.show_forward(index)
	
func _show_dir():
	super._show_dir()
	jump_button.get_node("Anim").stop()

func show_spin():
	for elem in amount_overlay.get_parent().get_children():
			elem.visible = false
	
	amount_overlay.get_parent().visible = true
	amount_overlay.visible = true
	go_button_ov.visible = true
	

func enable_repeat():
	_handle_next_panel(false)
	go_button_ov.visible = false
	am_spinbox.value_changed.connect(_on_selected)
	
func _on_selected(index):
	if index == 3:
		go_button_ov.visible = true
		go()
