class_name  UIProcedureMove extends Button

@export var button_asocciated:ColorRect = ColorRect.new()
@export var selected_container:UIProcedureSelected = UIProcedureSelected.new()

var picked = false
func _pressed():
	if picked:
		selected_container.remove_command(get_parent())
	else:
		selected_container.add_command(get_parent())
		
