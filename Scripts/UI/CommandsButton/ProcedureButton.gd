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
	proc_picked = selected_commands.procedure
	first_elem = proc_picked.get_next_command()
	dir = first_elem.dir
		
	set_button_dir(first_elem)
	
	
	game_manager.AddCommand(_get_command_type())
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
	self.procedure = original.procedure
	self.first_elem = original.first_elem
	
func _on_pop(val):
	pass
	#if (left >= 0):
	#	label.text = "x" + str(left)
	#	left -= 1
	
	
	
	
	

