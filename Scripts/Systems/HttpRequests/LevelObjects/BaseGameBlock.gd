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
	
func shouldLose(player):
	var curr_command = player.game_manager.current_command
	if (curr_command is IFButton && !from_if):
		return true
	return false
	
func come_from_if():
	from_if = true

func do_extras_when_landed(player):
	print("do extras when landed")
	pass
	
func do_extras(player):
	print("do extras")
	
func going_to_this_block(player):
	_inst.before_land_actions(player, self)
	pass
