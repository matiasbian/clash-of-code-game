extends Button

@export var manage_levels:Panel = Panel.new()

func _pressed():
	manage_levels.visible = true
