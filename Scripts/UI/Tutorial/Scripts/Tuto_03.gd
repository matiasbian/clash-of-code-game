extends TutoLevelTwo


func _get_dialogs():
	return [
		{
			"dialog": "¡Hola de nuevo!"
		},
		{
			"dialog": "En este nivel, aprenderemos un nuevo comando: PONER BOLITAS"
		},
		{
			"dialog": "Este comando permite PONER bolitas en un casillero"
		},
		{
			"dialog": 'En primer lugar, presiona el botón DERECHA para avanzar al primer casillero',
			"action": _show_sel_com_and_show
		},
		{
			"dialog": 'Ahora presiona el comando "PONER BOLITAS" para agregar bolitas',
			"action": show_avaialable_commands,
			"param": "Put"
		},
		{
			"dialog": "Con estos comandos ya agregariamos las bolitas al casillero",
			"action": _reparent_selected_commands,
			"param" : false
		},
		{
			"dialog": '',
			"action": show_forward
		},
		{
			"dialog": 'Ahora agrega DOS movimientos hacia ADELANTE para alcanzar el cofre'
		},
		{
			"dialog": "Presiona play para que ROBOTO ejecute el PROGRAMA"
		}
	]

	


func _show_button(button = "Right"):
	show_specific_command(button)
	game_manager.action_added.connect(self.go_and_remove)
	
	
	
