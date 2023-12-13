class_name BaseGameBlock extends Node

var pos:Vector2
var _block

signal before_check()
var _inst
var from_if


func _init(block):
	init(block)
	
func init(block):
	_block = block
	pos = Vector2(block["positionX"], block["positionY"])
	
func should_lose_on_enter(player):
	var curr_command = player.game_manager.current_command
	if (curr_command is IFButton && !from_if):
		return true
	return false
	
func should_lose_on_leave(player):
	return false
	
func come_from_if():
	from_if = true

func do_extras_when_landed(player):
	pass
	
func do_extras(player):
	print("Doing extras")
	pass
	
func going_to_this_block(player):
	_inst.before_land_actions(player, self)
	pass
