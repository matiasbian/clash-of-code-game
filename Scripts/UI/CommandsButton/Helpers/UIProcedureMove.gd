class_name  UIProcedureMove extends Button

@export var button_asocciated:ColorRect = ColorRect.new()
@export var selected_container:UIProcedureSelected = UIProcedureSelected.new()

func _pressed():
	selected_container.add_command(get_parent())
