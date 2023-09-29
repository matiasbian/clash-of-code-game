class_name BaseGameBlock extends Node

var pos:Vector2
signal before_check()

func _init(block):
	init(block)
	
func init(block):
	pos = Vector2(block["positionX"], block["positionY"])
	
func shouldLose(player):
	return false

func do_extras_when_landed(player):
	pass
	
func do_extras(player):
	print("Nothing to do")
	
func going_to_this_block(player):
	pass
