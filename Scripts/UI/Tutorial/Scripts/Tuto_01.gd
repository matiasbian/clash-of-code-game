extends TutoScriptBase

@export var available_commands:MarginContainer = MarginContainer.new()
@export var temp_available_commands_container:Panel = Panel.new()
@export var selected_commands:Node = Node.new()
@export var play_button:MarginContainer = MarginContainer.new()

var avail_parent
var selec_parent
var play_parent
var i = 0

func _ready():
	avail_parent = available_commands.get_parent()
	selec_parent = selected_commands.get_parent()
	play_parent = play_button.get_parent()
	
func _get_dialogs():
	return [
		{
			"dialog": "¡Hola!"
		},
		{
			"dialog": "¡Bienvenido a Clash of Codes!"
		},
		{
			"dialog": "Mi nombre es _____."
		},
		{
			"dialog": "Y seré tu guía durante este tutorial"
		},
		{
			"dialog": "Clash of codes es un juego que te enseñará conceptos fundamentales de la programación"
		},
		{
			"dialog": "Para este primer nivel, solo tenemos la opción de movernos hacia adelante",
			"action": show_avaialable_commands
		},
		{
			"dialog": "Como puedes ver, el comando se agrego a la lista de comandos elegidos",
			"action": _reparent_selected_commands
		},
		{
			"dialog": "Muy bien! Agrega 3 movimientos hacia adelante."
		},
		{
			"dialog": "Muy bien! Presiona el botón Play"
		}
	]

func show_avaialable_commands():
	_reparent()
	
func _reparent():
	temp_available_commands_container.visible = true
	
	
	avail_parent.remove_child(available_commands)
	temp_available_commands_container.add_child(available_commands)
	available_commands.set_owner(temp_available_commands_container)
	game_manager.action_added.connect(_re_reparent_avaiable)
	
	
func _re_reparent_avaiable(action):
	game_manager.action_added.disconnect(_re_reparent_avaiable)	
	available_commands.visible = false
	emit_signal("go_next")
	
	
func _reparent_selected_commands():
	selec_parent.remove_child(selected_commands)
	temp_available_commands_container.add_child(selected_commands)
	selected_commands.set_owner(temp_available_commands_container)
	game_manager.action_removed.connect(action_removed)
	
func action_removed(action):
	game_manager.action_removed.disconnect(action_removed)
	available_commands.visible = true
	game_manager.action_added.connect(add_three)	
	game_manager.action_removed.connect(rem_three)	
	emit_signal("go_next")
	
func add_three(action):
	i += 1
	
	if i == 3:
		available_commands.visible = false
		selected_commands.visible = false
	
		play_parent.remove_child(play_button)
		temp_available_commands_container.add_child(play_button)
		play_button.set_owner(temp_available_commands_container)
		
		emit_signal("go_next")
		
	
func rem_three(action):
	i -= 1
