extends TutoLevelTwo

@export var cond_overlay:Panel = Panel.new()
@export var true_overlay:Panel = Panel.new()
@export var false_overlay:Panel = Panel.new()
@export var op_true:OptionButton = OptionButton.new()
@export var op_false:OptionButton = OptionButton.new()

func _get_dialogs():
	return [
		{
			"dialog": "TUTORIAL_04_00"
		},
		{
			"dialog": "TUTORIAL_04_01"
		},
		{
			"dialog": 'TUTORIAL_04_02',
			"action": _show_sel_com_and_show
		},
		{
			"dialog": 'TUTORIAL_04_03',
			"action": _show_jump
		},
		{
			"dialog": 'TUTORIAL_04_04',
			"action": show_overlay_generic,
			"param": cond_overlay
		},
		{
			"dialog": 'TUTORIAL_04_05'
		},
		{
			"dialog": 'TUTORIAL_04_06',
			"action": show_true
		},
		{
			"dialog": 'TUTORIAL_04_07'
		},
		{
			"dialog": 'TUTORIAL_04_08'
		},
		{
			"dialog": 'TUTORIAL_04_09',
			"action": show_overlay_generic,
			"param": false_overlay
		},
		{
			"dialog": 'TUTORIAL_04_10',
			"action": enable_true
		},
		{
			"dialog": 'TUTORIAL_04_11',
			"action": _show_accept,
			"param": false_overlay
		},
		{
			"dialog": "TUTORIAL_04_12",
			"action": show_arrow,
			"params": false
		},
		{
			"dialog": 'TUTORIAL_04_13',
			"action": show_forward
		},
		{
			"dialog": 'TUTORIAL_04_14'
		},
		{
			"dialog": "TUTORIAL_04_15"
		},
	]

func _show_jump():
	show_avaialable_commands("IF")
	jump_button.pressed.connect(go)
	go_button_ov.pressed.connect(go)
	jump_child = 7
	
func _show_dir():
	super._show_dir()
	jump_button.get_node("Anim").stop()
	

func show_true():
	for elem in true_overlay.get_parent().get_children():
			elem.visible = false
	
	true_overlay.get_parent().visible = true
	true_overlay.visible = true
	go_button_ov.visible = true
	

func enable_true():
	_handle_next_panel(false)
	go_button_ov.visible = false
	op_false.item_selected.connect(_on_selected)
	
func _on_selected(index):
	if index == 1:
		_handle_next_panel(true)
		go_button_ov.visible = true
		go()
