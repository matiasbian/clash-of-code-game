class_name Procedure extends Node

var commands:Array = []
var active_command
var proc_name

func _init():
	pass
	
func add_command(c):
	commands.push_back(c)
	return commands.size() - 1
	
func copy_from(b):
	self.commands.append_array(b.commands)
	self.active_command = b.active_command
	self.proc_name = b.proc_name
	
func add_commands(cs):
	commands.append_array(cs)
	
func remove_command(c):
	commands.erase(c)
	
func remove_command_at(index):
	commands.remove_at(index)
	print(commands)

func get_queue():
	return commands

func get_next_command():
	active_command = commands.pop_front()
	return active_command
	

func is_empty():
	return commands.is_empty()
	
func jumps_picked():
	var jumps = 0
	for c in commands:
		if c is JumpButton:
			jumps += 1
	return jumps

