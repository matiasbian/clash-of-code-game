extends Button

@export var trigger_button = ActionButton.new()

func _pressed():
	trigger_button._pressed()
