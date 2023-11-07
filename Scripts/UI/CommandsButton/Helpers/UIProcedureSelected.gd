class_name UIProcedureSelected extends Node

var procedure:Procedure = Procedure.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_command(element):
	var clone = element.duplicate()
	add_child(clone)
	var asociated = clone.get_node("Button").button_asocciated.get_node("Button")
	var index = procedure.add_command(asociated)
	clone.get_node("Button").index = index
	clone.get_node("Button").picked = true
	clone.set_owner(self)

func remove_command(element, index):
	procedure.remove_command_at(index)
	element.queue_free()
	
func remove_all():
	for e in get_children():
		e.queue_free()
	procedure = Procedure.new()
