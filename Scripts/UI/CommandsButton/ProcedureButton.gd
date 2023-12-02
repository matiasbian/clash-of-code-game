class_name ProcedureButton extends ActionButton
		
@export var procedure_popup:Control = Control.new()
@export var accept_button:Button = Button.new()

@export var error_pop_up:Panel = Panel.new()

@export var selected_commands:UIProcedureSelected = UIProcedureSelected.new()

var proc_picked:Procedure = Procedure.new()
var first_elem 

func _ready():
	__ready()
	
	if !isSideMenu:
		return
		
	accept_button.pressed.connect(accept)
	

func _get_command_type():
	return self
	
func do_extras(player, targetPos):

	
	
	first_elem.do_extras(player, targetPos)
	
	#_on_pop(null)
	
	for v in proc_picked.commands:
		self.procedure.add_command(v)
	
func _pressed():
	if logical_disable:
		return
		
	if (isSideMenu):
		procedure_popup.visible = true
		#game_manager.AddCommand(_get_command_type())
	else:
		game_manager.RemoveCommand(index)

func accept():
	#proc_picked = selected_commands.
	
	#if (!iter.get_node("Button").can_perform(amount_spin.value)):
	#	error_pop_up.show_pop_up(iter.get_node("Button").get_perform_error(amount_spin.value))
	#	return
	selected_commands.close()
	
	var error = is_there_an_error()
	
	if (error != ""):
		error_pop_up.show_pop_up(error)
		return
	
	_show_label(selected_commands.procedure.proc_name)
	proc_picked = Procedure.new()
	proc_picked.copy_from(selected_commands.procedure)
	first_elem = proc_picked.get_next_command()
	dir = first_elem.dir
		
	set_button_dir(first_elem)
	
	
		
	game_manager.add_procedure(_get_command_type())
	
	selected_commands.remove_all()
	procedure_popup.visible = false
	
func cancel():
	procedure_popup.visible = false
	
func set_button_dir(button):
	button.dir = dir
	
func is_spike(button, player):		
	return button.get_subinstance() is JumpBlock
	
func get_dir():
	return dir
	
func set_extra_values(original):
	proc_picked = original.proc_picked
	self.procedure = Procedure.new()
	self.procedure.copy_from(original.procedure)
	self.first_elem = original.first_elem
	
func _on_pop(val):
	pass
	#if (left >= 0):
	#	label.text = "x" + str(left)
	#	left -= 1
	
func get_classname():
	return "ProcedureButton class"
	
func is_there_an_error():
	var jumps_used = selected_commands.procedure.jumps_picked()	
	if (selected_commands.procedure.is_empty()):
		return "No se puede crear procedimientos vacios"
	elif selected_commands.procedure.proc_name == "":
		return "Ingrese un nombre para el procedimiento"
	elif game_manager.jumps_availables < jumps_used:
		var text = "Se intento usar %s saltos, cuando solo hay disponible %s saltos" % [jumps_used, game_manager.jumps_availables]
		return text
	return ""
	
#Copied from base class - Due a godot BUG it was needed
func _show_label(text):
	get_parent().get_node("Button/Label").visible = true
	get_parent().get_node("Button/Label").text = text
	
	
	

