class_name UIProcedureSelected extends Node

var procedure:Procedure = Procedure.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_command(element):
	var clone = element.duplicate()
	add_child(clone)
	procedure.add_command(clone.get_node("Button").button_asocciated.get_node("Button"))
	clone.get_node("Button").picked = true
	clone.set_owner(self)

func remove_command(element):
	procedure.remove_command(element)
	element.queue_free()
