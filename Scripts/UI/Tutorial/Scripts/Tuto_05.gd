extends TutoLevelTwo

@export var act_overlay:Panel = Panel.new()
@export var amount_overlay:Panel = Panel.new()
@export var am_spinbox:SpinBox = SpinBox.new()

func _get_dialogs():
	return [
		{
			"dialog": "¡ROBOTO te saluda!"
		},
		{
			"dialog": "Otra vez..."
		},
		{
			"dialog": "En este nivel, aprenderemos un nuevo comando: FOR"
		},
		{
			"dialog": 'Presiona el comando "FOR" para crear una condicion',
			"action": _show_jump
		},
		{
			"dialog": 'En esta casilla se elige la dirección a la que quieres moverte',
			"action": _show_dir
		},
		{
			"dialog": 'En esta sección se elije la accion que se desea repetir',
			"action": show_overlay_generic,
			"param": act_overlay
		},
		{
			"dialog": 'En este caso, la condición por defecto está correcta'
		},
		{
			"dialog": 'Aqui se elije cuantas veces se desea ejecutar esa accion',
			"action": show_spin
		},
		{
			"dialog": 'En nuestro, caso deberíamos repetirla 3 veces'
		},
		{
			"dialog": 'Elije 3 repeticiones',
			"action": enable_repeat
		},
		{
			"dialog": 'Presiona aceptar para agregar el comando',
			"action": _show_accept,
			"param": amount_overlay
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

func _show_jump():
	show_avaialable_commands("For")
	jump_button.pressed.connect(go)
	go_button_ov.pressed.connect(go)
	jump_child = 8

func show_spin():
	for elem in amount_overlay.get_parent().get_children():
			elem.visible = false
	
	amount_overlay.get_parent().visible = true
	amount_overlay.visible = true
	go_button_ov.visible = true
	

func enable_repeat():
	go_button_ov.visible = false
	am_spinbox.value_changed.connect(_on_selected)
	
func _on_selected(index):
	if index == 3:
		go_button_ov.visible = true
		go()
