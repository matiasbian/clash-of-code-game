class_name Procedure extends Node

var commands:Array = []

func _init():
	pass
	
func add_command(c):
	commands.push_back(c)
	
func add_commands(cs):
	commands.append_array(cs)
	
func remove_command(c):
	commands.erase(c)

func get_queue():
	return commands

func get_next_command():
	return commands.pop_front()
	

func is_empty():
	return commands.is_empty()

