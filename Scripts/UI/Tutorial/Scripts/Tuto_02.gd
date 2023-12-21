class_name TutoLevelTwo extends TutoLevelOne

@export var dir_overlay:Panel = Panel.new()
@export var accept_overlay:Panel = Panel.new()
@export var jump_button:Button = Button.new()
@export var go_button_ov:Button = Button.new()

var jump_child = 5

func _get_dialogs():
	return [
		{
			"dialog": "¡Muy buen trabajo en el nivel anterior!"
		},
		{
			"dialog": "En este nivel, aprenderemos un nuevo comando: Salto"
		},
		{
			"dialog": 'Presiona el comando "SALTO" para evitar ser alcanzado por los pinches',
			"action": _show_jump
		},
		{
			"dialog": 'Aqui puedes elegir la direccion de salto',
			"action": _show_dir
		},
		{
			"dialog": 'En esta ocasión, no la cambiaremos'
		},
		{
			"dialog": 'Presiona "ACEPTAR" para agregar el comando',
			"action": _show_accept
		},
		{
			"dialog": "Como puedes ver, el comando se agrego al programa a ejecutar.",
			"action": show_arrow
		},
		{
			"dialog": 'Ahora agrega DOS VECES el comando "AVANZAR" para alcanzar el cofre',
			"action": show_forward
		},
		{
			"dialog": 'Ahora agrega DOS VECES el comando "AVANZAR" para alcanzar el cofre'
		},
		{
			"dialog": "Presiona play para que ROBOTO ejecute el PROGRAMA"
		},
	]
	
func _show_jump():
	show_avaialable_commands("Jump")
	jump_button.pressed.connect(go)
	go_button_ov.pressed.connect(go)
	
func show_arrow(show = true):
	var button = _reparent_selected_commands(show)
	button.get_node("Button").logical_disable = true
	game_manager.action_removed.disconnect(action_removed)
	
func _show_sel_com_and_show():
	jump_child = 7
	show_specific_command()
	
	temp_available_commands_container.visible = true
	
	avail_parent.remove_child(available_commands)
	temp_available_commands_container.add_child(available_commands)
	available_commands.set_owner(temp_available_commands_container)
	
	game_manager.action_added.connect(self.go_and_remove)
	
func go_and_remove(btn):
	game_manager.action_added.disconnect(go_and_remove)
	go()
	
	
func show_forward(index = 0):
	_handle_next_panel(false)
	action_disabled = true
	disable_jump_select()
	action_removed(null)
	
	var right = available_commands.get_node("ScrollContainer/VBoxContainer").get_child(index)
	right.get_node("Button").disabled = false
	right.get_node("Button/Anim").play("Highlight")
	
	var jump = available_commands.get_node("ScrollContainer/VBoxContainer").get_child(jump_child)
	print(jump.name)
	jump.get_node("Button").disabled = true
	jump.get_node("Button/Anim").stop()
	jump.get_node("Button/Anim").play("Idle")
	
	var scroll:ScrollContainer = available_commands.get_node("ScrollContainer")
	scroll.ensure_control_visible(right)
	
	limit = 2
	game_manager.action_added.connect(add_three)	
	game_manager.action_removed.connect(rem_three)	
	
func disable_jump_select():
	var cont = selected_commands.get_node("Panel/ColorRect/MarginContainer/ScrollContainer/HBoxContainer")
	
	for c in cont.get_children():
		if c.visible:
			c.get_node("Button/Anim").stop()
			c.get_node("Button/Anim").play("Idle")
			c.get_node("Button/Arrows/ArrowBR").visible = false
			c.get_node("Button").logical_disable = true
	
	
func go():
	emit_signal("go_next")
	
func _show_dir():
	_handle_next_panel(true)
	dir_overlay.get_parent().visible = true
	dir_overlay.visible = true
	
func show_overlay_generic(overlay):
	for elem in overlay.get_parent().get_children():
		if elem.name != "Go":
			elem.visible = false
	
	overlay.get_parent().visible = true
	overlay.visible = true
	


func _show_accept(extra_hide = null):
	_handle_next_panel(false)
	go_button_ov.visible = false
	dir_overlay.visible = false
	accept_overlay.visible = true
	
	if (extra_hide):
		extra_hide.visible = false
	
