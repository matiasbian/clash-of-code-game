class_name UIProcedureSelected extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_command(element):
	var clone = element.duplicate()
	add_child(clone)
	clone.set_owner(self)
