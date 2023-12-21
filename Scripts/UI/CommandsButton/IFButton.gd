class_name IFButton extends ActionButton

@export var if_popup:Control = Control.new()

@onready var accept_button:Button = if_popup.get_node("ColorRect/MarginContainer/Container/Buttons/Btn")
@onready var cancel_button:Button = if_popup.get_node("ColorRect/MarginContainer/Container/Buttons/Btn2")

@onready var true_drop:OptionButton = if_popup.get_node("ColorRect/MarginContainer/Container/True/OptionButton")
@onready var false_drop:OptionButton = if_popup.get_node("ColorRect/MarginContainer/Container/False/OptionButton")
@onready var cond_drop:OptionButton = if_popup.get_node("ColorRect/MarginContainer/Container/Cond/OptionButton")

@export var move_right:ColorRect = ColorRect.new()
@export var move_left:ColorRect = ColorRect.new()
@export var move_up:ColorRect = ColorRect.new()
@export var move_down:ColorRect = ColorRect.new()

@export var take:ColorRect = ColorRect.new()
@export var put:ColorRect = ColorRect.new()

@export var error_pop_up:Panel = Panel.new()

var true_branch
var false_branch
var cond
var condRight

var dirs:Array = [MovementBlock.Directions.Right, MovementBlock.Directions.Left, MovementBlock.Directions.Top, MovementBlock.Directions.Bottom]
var buttons:Dictionary
var condList:Array
func _ready():
	__ready()
	
	if !isSideMenu:
		return
	accept_button.pressed.connect(accept)
	cancel_button.pressed.connect(cancel)
	
	condList = [{"cond": is_take, "rightAction": TakeButton}, {"cond": is_put, "rightAction": PutButton}]
	
	buttons[0] = move_right
	buttons[1] = move_left
	buttons[2] = move_up
	buttons[3] = move_down
	
	buttons[20] = take
	buttons[21] = put
	

func _get_command_type():
	return self
	
func do_extras(player):
	var targetBlock = game_manager.get_block(player.position)
	
	if !targetBlock is IfBlock:
		return

	if (cond.call(targetBlock, player)):
		true_branch.get_node("Button").do_extras(player)
	else:
		false_branch.get_node("Button").do_extras(player)
	
func _pressed():
	if logical_disable:
		return
		
	if (isSideMenu):
		if_popup.visible = true
		#game_manager.AddCommand(_get_command_type())
	else:
		game_manager.RemoveCommand(index)

func accept():
	true_branch = buttons[true_drop.get_selected_id()]
	false_branch = buttons[false_drop.get_selected_id()]
	
	cond = condList[cond_drop.get_selected_id()].cond
	condRight = condList[cond_drop.get_selected_id()].rightAction

	var extra_info = get_node("ExtraInfo")
	extra_info.get_node("Panel/Icon").texture = cond_drop.icon
	extra_info.get_node("Bot/Cont/Panel/Cont1/Icon1").texture = true_drop.icon
	extra_info.get_node("Bot/Cont/Panel2/Cont2/Icon2").texture = false_drop.icon
	
	game_manager.AddCommand(_get_command_type())
	if_popup.visible = false
	
	
func cancel():
	if_popup.visible = false
	
func is_spike(button, player):		
	return button.get_subinstance() is JumpBlock
	
func is_take(button, player):
	return button.get_subinstance() is BallBlock #TODO
	
func is_put(button, player):		
	return button.get_subinstance() is PutBallBlock #TODO
	
func set_extra_values(original):
	true_branch = original.true_branch
	false_branch = original.false_branch
	cond = original.cond
	condRight = original.condRight
	condList = original.condList
	
	var extra_info = get_node("ExtraInfo")
	extra_info.get_node("Panel").visible = true
	extra_info.get_node("Bot").visible = true
	
	extra_info.get_node("Panel/Icon").texture = original.get_node("ExtraInfo").get_node("Panel/Icon").texture
	extra_info.get_node("Bot/Cont/Panel/Cont1/Icon1").texture = original.true_drop.icon
	extra_info.get_node("Bot/Cont/Panel2/Cont2/Icon2").texture = original.false_drop.icon
	
func is_wrong_true_branch():
	return str(true_branch.get_node("Button").get_script()) != str(condRight)
	
func is_right_true_branch():
	return str(true_branch.get_node("Button").get_script()) != str(condRight)
	
func get_classname():
	return "IfButton class"
	
