extends TutoLevelTwo

@export var process:Panel = Panel.new()
@export var cancel_button:Button = Button.new()
@export var add_button:Button = Button.new()
@export var commands_Panel:Panel = Panel.new()

@export var name_panel:Panel = Panel.new()
@export var name_line_edit:LineEdit = LineEdit.new()

@export var go_button_ov2:Button = Button.new()
@export var subcommand_added:UIProcedureSelected = UIProcedureSelected.new()
@export var subcommand_available:HBoxContainer = HBoxContainer.new()

@export var accept_overlay2:Panel = Panel.new()
@export var accept_btn_2:Button = Button.new()

@export var select_ovr:Panel = Panel.new()

@export var item_list:ItemList = ItemList.new()

func _get_dialogs():
	return [
		{
			"dialog": "TUTORIAL_06_00"
		},
		{
			"dialog": "TUTORIAL_06_01"
		},
		{
			"dialog": 'TUTORIAL_06_02',
			"action": _show_procedure
		},
		{
			"dialog": 'TUTORIAL_06_03'
		},
		{
			"dialog": 'TUTORIAL_06_04'
		},
		{
			"dialog": 'TUTORIAL_06_05'
		},
		{
			"dialog": 'TUTORIAL_06_06',
			"action": _show_add
		},
		{
			"dialog": 'TUTORIAL_06_07',
			"action": show_name
		},
		{
			"dialog": 'TUTORIAL_06_08',
			"action": show_commands
		},
		{
			"dialog": 'TUTORIAL_06_09'
		},
		{
			"dialog": 'TUTORIAL_06_10'
		},
		{
			"dialog": 'TUTORIAL_06_11'
		},
		{
			"dialog": "TUTORIAL_06_12",
			"action": suscribe_select
		},
		{
			"dialog": 'TUTORIAL_06_13',
			"action": show_overlay_generic,
			"param": accept_overlay
		},
		{
			"dialog": "TUTORIAL_06_14",
			"action": show_arrow
		},
		{
			"dialog": "TUTORIAL_06_15",
			"action": show_play
		},
	]
	
func _show_procedure():
	_handle_next_panel(false)
	game_manager.on_victory.connect(_on_win_extras)
	jump_button.pressed.connect(_go_and_show_next)
	go_button_ov.pressed.connect(go)
	add_button.pressed.connect(go)
	
	var container = available_commands.get_node("ScrollContainer/VBoxContainer")	
	for c in container.get_children():
		c.get_node("Button").disabled = true
		
	#reparent()
	_reparent2()
	cancel_button.disabled = true
	
	
	go_button_ov.get_parent().visible = true
	go_button_ov.visible = true
	
func _go_and_show_next():
	_handle_next_panel(true)
	go()
	
	
func _reparent2():
	temp_available_commands_container.visible = true
	
	process.get_parent().remove_child(process)
	temp_available_commands_container.add_child(process)
	process.set_owner(temp_available_commands_container)
	
	game_manager.action_added.connect(_re_reparent_avaiable)
	
func _show_add():
	go_button_ov.visible = false
	_show_dir()
	_handle_next_panel(false)
	
func show_name():
	go_button_ov2.visible = false
	show_overlay_generic(name_panel)
	name_line_edit.text_changed.connect(_on_text_changed)
	
func show_panels():
	go_button_ov2.visible = false
	show_overlay_generic(name_panel)
	name_line_edit.text_changed.connect(_on_text_changed)
	
func show_commands():
	show_overlay_generic(commands_Panel)
	subcommand_added.command_added.connect(_on_command_added_1)
	_disable_elem("Right")
	
	
func _on_command_added_1(command):
	_disable_elem("Top")
	
	subcommand_added.command_added.disconnect(_on_command_added_1)
	subcommand_added.command_added.connect(_on_command_added_2)
	command.get_node("Button/Anim").play("Highlight")
	command.get_node("Button/Anim").stop()
	command.get_node("Button/Anim").play("Idle")
	go()
	
	
func _on_command_added_2(command):
	_disable_elem("Right")
	subcommand_added.command_added.disconnect(_on_command_added_2)
	subcommand_added.command_added.connect(_on_command_added_3)
	command.get_node("Button/Anim").play("Highlight")
	command.get_node("Button/Anim").stop()
	command.get_node("Button/Anim").play("Idle")
	go()
	
func _on_command_added_3(command):
	command.get_node("Button/Anim").play("Highlight")
	command.get_node("Button/Anim").stop()
	command.get_node("Button/Anim").play("Idle")
	show_overlay_generic(accept_overlay2)
	accept_btn_2.pressed.connect(_on_accept_1)
	go()
	
func _on_accept_1():
	show_overlay_generic(select_ovr)
	go()
	
	
	
func _on_text_changed(text):
	if (text.to_lower() == "roboto".to_lower()):
		go()
		
func _disable_elem(name_to):
	for c in subcommand_available.get_children():
		c.get_node("Button").disabled = c.name != name_to
		c.get_node("Button/Anim").stop()
		c.get_node("Button/Anim").play("Idle")
		if (c.name == name_to):
			c.get_node("Button/Anim").play("Highlight")
			
func suscribe_select():
	item_list.item_selected.connect(_go_accept)
	
func _go_accept(i):
	go()
	
func show_play():
	play_parent.remove_child(play_button)
	temp_available_commands_container.add_child(play_button)
	play_button.set_owner(temp_available_commands_container)
	game_manager.startedPlay.connect(_game_started)
	available_commands.visible = false
	selected_commands.visible = false
	_handle_next_panel(false)
	
func _game_started():
	temp_available_commands_container.remove_child(selected_commands)
	avail_parent.add_child(selected_commands)
	selected_commands.set_owner(avail_parent)
	
	super._game_started()


	
	
