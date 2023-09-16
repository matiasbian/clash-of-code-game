class_name BaseGameBlock extends Node

func _init():
	print("empty init")

func shouldLose(player):
	return false
	
func do_extras(player):
	print("Nothing to do")
