class_name BaseGameBlock extends Node

var pos:Vector2
var _block

signal before_check()
var _inst

func _init(block):
	init(block)
	
func init(block):
	_block = block
	pos = Vector2(block["positionX"], block["positionY"])
	
func shouldLose(player):
	print("Should lose")
	return false

func do_extras_when_landed(player):
	print("do extras when landed")
	pass
	
func do_extras(player):
	print("do extras")
	
func going_to_this_block(player):
	_inst.before_land_actions(player, self)
	pass
