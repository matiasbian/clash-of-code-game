extends TutoLevelTwo

@export var process:Panel = Panel.new()
@export var cancel_button:Button = Button.new()
@export var add_button:Button = Button.new()

@export var name_panel:Panel = Panel.new()

func _get_dialogs():
	return [
		{
			"dialog": "¡Muy buen trabajo en el quinto nivel!"
		},
		{
			"dialog": "En este nivel, aprenderemos un nuevo comando: PROCEDIMIENTO"
		},
		{
			"dialog": 'Presiona el comando "PROCEDIMIENTOS" para crear una condicion',
			"action": _show_procedure
		},
		{
			"dialog": 'En esta casilla se elige la dirección a la que quieres moverte'
		},
		{
			"dialog": 'En esta sección se elije la accion que se desea repetir',
			"action": _show_add
		},
		{
			"dialog": 'En este caso, la condición por defecto está correcta',
			"action": show_overlay_generic,
			"param": name_panel
		},
		{
			"dialog": 'Aqui se elije cuantas veces se desea ejecutar esa accion'
		},
		{
			"dialog": 'En nuestro, caso deberíamos repetirla 3 veces'
		},
		{
			"dialog": 'Elije 3 repeticiones'
		},
		{
			"dialog": 'Presiona aceptar para agregar el comando',
			"action": _show_accept,
		},
		{
			"dialog": "Como puedes ver, el comando se agrego al programa a ejecutar.",
			"action": show_arrow
		},
		{
			"dialog": 'Ahora agrega DOS VECES el comando "ARRIBA" para alcanzar el cofre',
			"action": show_forward,
			"param": 3
		},
		{
			"dialog": 'Ahora agrega DOS VECES el comando "AVANZAR" para alcanzar el cofre'
		},
		{
			"dialog": "Presiona play para que ROBOTO ejecute el PROGRAMA"
		},
	]
	
func _show_procedure():
	game_manager.on_victory.connect(_on_win_extras)
	jump_button.pressed.connect(go)
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
	
	
func _reparent2():
	temp_available_commands_container.visible = true
	
	process.get_parent().remove_child(process)
	temp_available_commands_container.add_child(process)
	process.set_owner(temp_available_commands_container)
	
	game_manager.action_added.connect(_re_reparent_avaiable)
	
func _show_add():
	go_button_ov.visible = false
	_show_dir()
