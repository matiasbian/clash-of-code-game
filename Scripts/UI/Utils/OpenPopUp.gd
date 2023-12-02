extends Button

@export var pop_up:Control = Control.new()

func _pressed():
	pop_up.visible = true
