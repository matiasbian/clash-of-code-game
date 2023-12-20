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
			"dialog": "Este comando permite extraer todas las bolitas de un casillero"
		},
		{
			"dialog": 'En primer lugar, presiona el botón DERECHA para avanzar al primer casillero',
			"action": _show_sel_com_and_show
		},
		{
			"dialog": 'Ahora presiona el comando "SACAR BOLITAS" para recogerlas todas',
			"action": show_avaialable_commands,
			"param": "Take"
		},
		{
			"dialog": "Con estos comandos ya extraeriamos las bolitas del casillero",
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
func _show_sel_com_and_show():
	jump_child = 6
	show_specific_command()
	
	temp_available_commands_container.visible = true
	
	avail_parent.remove_child(available_commands)
	temp_available_commands_container.add_child(available_commands)
	available_commands.set_owner(temp_available_commands_container)
	
	game_manager.action_added.connect(self.go_and_remove)
	
func go_and_remove(btn):
	game_manager.action_added.disconnect(go_and_remove)
	go()
	

func _show_button(button = "Right"):
	show_specific_command(button)
	game_manager.action_added.connect(self.go_and_remove)
	
	
	
