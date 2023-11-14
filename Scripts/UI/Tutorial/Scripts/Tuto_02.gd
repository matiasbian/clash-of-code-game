extends TutoLevelOne

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
			"dialog": 'DIRECCION',
			"action": _show_dir
		},
		{
			"dialog": 'ACEPTAR',
			"action": _show_accept
		},
		{
			"dialog": "Como puedes ver, el comando se agrego al programa a ejecutar.",
			"action": _reparent_selected_commands
		},
		{
			"dialog": 'Ahora agrega el comando "AVANZAR" para alcanzar el cofre',
		},
		{
			"dialog": "¡Muy bien! Ahora agrega el comando AVANZAR para alcanzar el cofre",
			"action": _reparent_selected_commands
		},
		
	]
	
func _show_jump():
	show_avaialable_commands("Jump")
	jump_button.pressed.connect(go)
	go_button_ov.pressed.connect(go)
	
func go():
	emit_signal("go_next")
	
func _show_dir():
	dir_overlay.get_parent().visible = true
	dir_overlay.visible = true

func _show_accept():
	go_button_ov.visible = false
	dir_overlay.visible = false
	accept_overlay.visible = true
	
