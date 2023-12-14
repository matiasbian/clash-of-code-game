class_name TutoLevelOne extends TutoScriptBase

@export var available_commands:MarginContainer = MarginContainer.new()
@export var temp_available_commands_container:Panel = Panel.new()
@export var selected_commands:Node = Node.new()
@export var play_button:MarginContainer = MarginContainer.new()
@export var overall_button:Button = Button.new()
@export var next_panel:Panel = Panel.new()

var avail_parent
var selec_parent
var play_parent
var i = 0
var limit = 3

var to_deanim_elem = "Right"

var action_disabled

func _ready():
	next_panel.visible = true
	avail_parent = available_commands.get_parent()
	selec_parent = selected_commands.get_parent()
	play_parent = play_button.get_parent()
	overall_button.pressed.connect(_go_next)
	
func _handle_next_panel(state):
	next_panel.visible = state
	
func _get_dialogs():
	return [
		{
			"dialog": "TUTORIAL_01_00"
		},
		{
			"dialog": "TUTORIAL_01_01"
		},
		{
			"dialog": "TUTORIAL_01_02"
		},
		{
			"dialog": "TUTORIAL_01_03"
		},
		{
			"dialog": "TUTORIAL_01_04"
		},
		{
			"dialog": "TUTORIAL_01_05"
		},
		{
			"dialog": "TUTORIAL_01_06"
		},
		{
			"dialog": "TUTORIAL_01_07",
			"action": show_avaialable_commands
		},
		{
			"dialog": "TUTORIAL_01_08",
			"action": _reparent_selected_commands
		},
		{
			"dialog": "TUTORIAL_01_09",
			"action": _disable_aux
		},
		{
			"dialog": "TUTORIAL_01_10"
		},
		{
			"dialog": "TUTORIAL_01_11"
		}
	]

func show_avaialable_commands(button = "Right"):
	_handle_next_panel(false)
	game_manager.on_victory.connect(_on_win_extras)
	var container = available_commands.get_node("ScrollContainer/VBoxContainer")
	var scroll:ScrollContainer = available_commands.get_node("ScrollContainer")
	
	for c in container.get_children():
		if (c.name != button):
			c.get_node("Button").disabled = true
		else:
			c.get_node("Button/Anim").play("Highlight")
			scroll.ensure_control_visible(c)
	_reparent()
	
func _reparent():
	temp_available_commands_container.visible = true
	
	avail_parent.remove_child(available_commands)
	temp_available_commands_container.add_child(available_commands)
	available_commands.set_owner(temp_available_commands_container)
	
	game_manager.action_added.connect(_re_reparent_avaiable)
	
	
func _re_reparent_avaiable(action):
	game_manager.action_added.disconnect(_re_reparent_avaiable)	

	temp_available_commands_container.remove_child(available_commands)
	avail_parent.add_child(available_commands)
	available_commands.set_owner(avail_parent)
	available_commands.visible = false
	
	emit_signal("go_next")
	
	
func _reparent_selected_commands():
	_handle_next_panel(true)
	selec_parent.remove_child(selected_commands)
	temp_available_commands_container.add_child(selected_commands)
	selected_commands.set_owner(temp_available_commands_container)
	game_manager.action_removed.connect(action_removed)
	overall_button.disabled = false
	
	#highlight selected command
	var button = selected_commands.get_node("Panel/ColorRect/MarginContainer/ScrollContainer/HBoxContainer").get_child(4)
	button.get_node("Button/Arrows/ArrowBR").visible = true
	button.get_node("Button").logical_disable = true
	return button
	
func action_removed(action):
	if !action_disabled:
		emit_signal("go_next")
		
	action_disabled = true
	temp_available_commands_container.remove_child(selected_commands)
	avail_parent.add_child(selected_commands)
	selected_commands.set_owner(avail_parent)
	
	game_manager.action_removed.disconnect(action_removed)
	available_commands.visible = true
	game_manager.action_added.connect(add_three)	
	game_manager.action_removed.connect(rem_three)	
	emit_signal("go_next")
	
func add_three(action):
	i += 1
	
	if i == limit:
		#available_commands.visible = false
		#selected_commands.visible = false
	
		play_parent.remove_child(play_button)
		temp_available_commands_container.add_child(play_button)
		play_button.set_owner(temp_available_commands_container)
		game_manager.startedPlay.connect(_game_started)
		available_commands.visible = false
		selected_commands.visible = false
		emit_signal("go_next")
		
		var container = available_commands.get_node("ScrollContainer/VBoxContainer")
		for c in container.get_children():
			if (c.name == to_deanim_elem):
				c.get_node("Button/Anim").stop()				
				c.get_node("Button/Anim").play("Idle")
		
	
func rem_three(action):
	i -= 1

func _game_started():
	temp_available_commands_container.remove_child(play_button)
	play_parent.add_child(play_button)
	play_button.set_owner(play_parent)
	
	temp_available_commands_container.visible = false
	available_commands.visible = true
	selected_commands.visible = true
	emit_signal("go_next")	
	
	
func _go_next():
	emit_signal("go_next")
	overall_button.pressed.disconnect(_go_next)
	overall_button.visible = false
	
func _disable_aux():
	_handle_next_panel(false)
	action_disabled = true
	var cont = selected_commands.get_node("Panel/ColorRect/MarginContainer/ScrollContainer/HBoxContainer")
	var scroll:ScrollContainer = available_commands.get_node("ScrollContainer")
	
	for c in cont.get_children():
		if c.visible:
			c.get_node("Button/Anim").stop()
			c.get_node("Button/Anim").play("Highlight")
			
			scroll.ensure_control_visible(c)
			c.get_node("Button/Arrows/ArrowBR").visible = false
			c.get_node("Button").logical_disable = false

func _on_win_extras(val):
	selected_commands.visible = false
	play_button.visible = false
	available_commands.visible = false
