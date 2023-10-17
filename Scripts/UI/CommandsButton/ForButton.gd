class_name ForButton extends ActionButton

@export var for_popup:Control = Control.new()

@onready var accept_button:Button = for_popup.get_node("ColorRect/MarginContainer/Container/Buttons/Btn")
@onready var cancel_button:Button = for_popup.get_node("ColorRect/MarginContainer/Container/Buttons/Btn2")

@onready var dir_drop:OptionButton = for_popup.get_node("ColorRect/MarginContainer/Container/Form/Dir/OptionButton")
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
	
	buttons[10] = jump_right
	buttons[11] = jump_left
	buttons[12] = jump_up
	buttons[13] = jump_down
	

func _get_command_type():
	return self
	
func do_extras(player, targetPos):
	var targetBlock = game_manager.get_block(targetPos)

	var button = iter.get_node("Button")
	button.do_extras(player, targetPos)
	_on_pop(null)
	
	for v in range(0, i):
		self.sub_queue.push_back(button)
	
func _pressed():
	if (isSideMenu):
		for_popup.visible = true
		#game_manager.AddCommand(_get_command_type())
	else:
		game_manager.RemoveCommand(index)

func accept():
	iter = buttons[iter_drop.get_selected_id() + dir_drop.get_selected_id()]
	
	dir = dirs[dir_drop.get_selected_id()]
	i = amount_spin.value -1
	left = i
	
	if (!iter.get_node("Button").can_perform(amount_spin.value)):
		error_pop_up.show_pop_up(iter.get_node("Button").get_perform_error(amount_spin.value))
		print("ER OR")
		return
		
	set_button_dir(iter.get_node("Button"))
	
	game_manager.AddCommand(_get_command_type())
	for_popup.visible = false
	
func cancel():
	for_popup.visible = false
	
func set_button_dir(button):
	button.dir = dir
	
func is_spike(button, player):		
	return button.get_subinstance() is JumpBlock
	
func get_dir():
	return dir
	
func set_extra_values(original):
	iter = original.iter
	i = original.i
	left = original.left
	
	label = get_node("Label")
	label.visible = true
	label.text = "x" + str(left + 1)	
	self.sub_queue = original.sub_queue
	
func _on_pop(val):
	if (left >= 0):
		label.text = "x" + str(left)
		left -= 1
	
	
	
	
	
