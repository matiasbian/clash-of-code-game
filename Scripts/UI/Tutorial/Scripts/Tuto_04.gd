extends TutoLevelTwo

@export var cond_overlay:Panel = Panel.new()
@export var true_overlay:Panel = Panel.new()
@export var false_overlay:Panel = Panel.new()
@export var op_true:OptionButton = OptionButton.new()

func _get_dialogs():
	return [
		{
			"dialog": "¡Muy buen trabajo en el tercer nivel!"
		},
		{
			"dialog": "En este nivel, aprenderemos un nuevo comando: IF"
		},
		{
			"dialog": 'Presiona el comando "IF" para crear una condicion',
			"action": _show_jump
		},
		{
			"dialog": 'En esta casilla se elige la dirección a la que quieres moverte',
			"action": _show_dir
		},
		{
			"dialog": 'En esta sección se elije la condición que corresponda a la celda',
			"action": show_overlay_generic,
			"param": cond_overlay
		},
		{
			"dialog": 'En este caso, la condición por defecto está correcta'
		},
		{
			"dialog": 'Aqui se elije que acción ejecutar en el caso de ser correcta la condición',
			"action": show_true
		},
		{
			"dialog": 'En nuestro, caso si hay pinches, Roboto debe saltar.'
		},
		{
			"dialog": 'Elije la opcion "SALTO" dentro de este menu',
			"action": enable_true
		},
		{
			"dialog": 'En esta sección, se debe seleccionar que acción tomar en caso de que la condición sea falsa',
			"action": show_overlay_generic,
			"param": false_overlay
		},
		{
			"dialog": 'En este caso, la condición por defecto está correcta'
		},
		{
			"dialog": 'Presiona aceptar para agregar el comando',
			"action": _show_accept,
			"param": false_overlay
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
	show_avaialable_commands("IF")
	jump_button.pressed.connect(go)
	go_button_ov.pressed.connect(go)
	jump_child = 7

func show_true():
	for elem in true_overlay.get_parent().get_children():
			elem.visible = false
	
	true_overlay.get_parent().visible = true
	true_overlay.visible = true
	go_button_ov.visible = true
	

func enable_true():
	go_button_ov.visible = false
	op_true.item_selected.connect(_on_selected)
	
func _on_selected(index):
	if index == 1:
		go_button_ov.visible = true
		go()
