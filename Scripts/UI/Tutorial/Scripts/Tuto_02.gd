class_name TutoLevelTwo extends TutoLevelOne

@export var dir_overlay:Panel = Panel.new()
@export var accept_overlay:Panel = Panel.new()
@export var jump_button:Button = Button.new()
@export var go_button_ov:Button = Button.new()

func _get_dialogs():
	return [
		{
			"dialog": "¡Muy buen trabajo en el primer nivel!"
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
			"dialog": 'En esta ocasión, no cambiaremos nada'
		},
		{
			"dialog": 'Presiona aceptar para agregar el comando',
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
	print("SHOWO")
	show_avaialable_commands("Jump")
	jump_button.pressed.connect(go)
	go_button_ov.pressed.connect(go)
	
func show_arrow():
	var button = _reparent_selected_commands()
	button.get_node("Button").logical_disable = true
	game_manager.action_removed.disconnect(action_removed)
	
	
func show_forward():
	action_disabled = true
	disable_jump_select()
	action_removed(null)
	
	var right = available_commands.get_node("ScrollContainer/VBoxContainer").get_child(0)
	right.get_node("Button").disabled = false
	right.get_node("Button/Anim").play("Highlight")
	
	var jump = available_commands.get_node("ScrollContainer/VBoxContainer").get_child(5)
	jump.get_node("Button").disabled = true
	jump.get_node("Button/Anim").stop()
	jump.get_node("Button/Anim").play("Idle")
	
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
	dir_overlay.get_parent().visible = true
	dir_overlay.visible = true

func _show_accept():
	go_button_ov.visible = false
	dir_overlay.visible = false
	accept_overlay.visible = true
	
