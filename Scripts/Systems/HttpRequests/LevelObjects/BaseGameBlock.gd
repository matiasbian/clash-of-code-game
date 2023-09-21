class_name BaseGameBlock extends Node

var pos:Vector2

func _init(block):
	pos = Vector2(block["positionX"], block["positionY"])

func shouldLose(player):
	return false
	
func do_extras(player):
	print("Nothing to do")
