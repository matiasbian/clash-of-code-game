extends TutoLevelTwo


func _get_dialogs():
	return [
		{
			"dialog": "¡Hola de nuevo!"
		},
		{
			"dialog": "En este nivel, aprenderemos un nuevo comando: SACAR BOLITAS"
		},
		{
			"dialog": 'Presiona el comando "SACAR BOLITAS" para recogerlas todas',
			"action": _show_jump
		},
		{
			"dialog": 'Aqui puedes elegir la direccion de recoleccion',
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
	show_avaialable_commands("Take")
	jump_button.pressed.connect(go)
	go_button_ov.pressed.connect(go)
	jump_child = 6
