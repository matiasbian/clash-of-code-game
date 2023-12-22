class_name ForButton extends ActionButton

@export var for_popup:Control = Control.new()

@onready var accept_button:Button = for_popup.get_node("ColorRect/MarginContainer/Container/Buttons/Btn")
@onready var cancel_button:Button = for_popup.get_node("ColorRect/MarginContainer/Container/Buttons/Btn2")

@onready var iter_drop:OptionButton = for_popup.get_node("ColorRect/MarginContainer/Container/Form/True/OptionButton")
@onready var amount_spin:SpinBox = for_popup.get_node("ColorRect/MarginContainer/Container/Form/Amount/SpinBox")


@export var move_right:ColorRect = ColorRect.new()
@export var move_left:ColorRect = ColorRect.new()
@export var move_up:ColorRect = ColorRect.new()
@export var move_down:ColorRect = ColorRect.new()

@export var jump_right:ColorRect = ColorRect.new()
@export var jump_left:ColorRect = ColorRect.new()
@export var jump_up:ColorRect = ColorRect.new()
@export var jump_down:ColorRect = ColorRect.new()

@export var take:ColorRect = ColorRect.new()
@export var put:ColorRect = ColorRect.new()

@export var label:Label = Label.new()
@export var error_pop_up:Panel = Panel.new()

var iter
var i
var left

var dirs:Array = [MovementBlock.Directions.Right, MovementBlock.Directions.Left, MovementBlock.Directions.Top, MovementBlock.Directions.Bottom]
var buttons:Dictionary
var condList:Array
func _ready():
	__ready()
	
	if !isSideMenu:
		return
	accept_button.pressed.connect(accept)
	cancel_button.pressed.connect(cancel)
	
	condList = [is_spike]
	
	buttons[0] = move_right
	buttons[1] = move_left
	buttons[2] = move_up
	buttons[3] = move_down
	
	buttons[20] = take
	buttons[21] = put
	

func _get_command_type():
	return self
	
func do_extras(player):
	var button = iter.get_node("Button")
	button.do_extras(player)
	_on_pop(null)
	
	for v in range(0, i):
		self.procedure.add_command(button)
	
func _pressed():
	if logical_disable:
		return
	
	if (isSideMenu):
		for_popup.visible = true
		#game_manager.AddCommand(_get_command_type())
	else:
		game_manager.RemoveCommand(index)

func accept():
	iter = buttons[iter_drop.get_selected_id()]
	
	i = amount_spin.value -1
	left = i
	
	if (!iter.get_node("Button").can_perform(amount_spin.value)):
		error_pop_up.show_pop_up(iter.get_node("Button").get_perform_error(amount_spin.value))
		return
	
	var extra_info = get_node("ExtraInfo")
	extra_info.get_node("Panel/Icon").texture = iter_drop.icon
	
	game_manager.AddCommand(_get_command_type())
	for_popup.visible = false
	
func cancel():
	for_popup.visible = false
	
func is_spike(button, player):		
	return button.get_subinstance() is JumpBlock
	
func set_extra_values(original):
	iter = original.iter
	i = original.i
	left = original.left
	
	label = get_node("Label")
	label.visible = true
	label.text = "x" + str(left + 1)	
	self.procedure = original.procedure
	
	var extra_info = get_node("ExtraInfo")
	extra_info.get_node("Panel/Icon").texture = original.iter_drop.icon
	extra_info.get_node("Panel").visible = true
	
func _on_pop(val):
	if (left >= 0):
		label.text = "x" + str(left)
		left -= 1
		
func get_classname():
	return "ForButton class"
	
	
	
	
	
