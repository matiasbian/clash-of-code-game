extends Button

@export var pop_up:Control = Control.new()

var i18n = TextTo18n.new("CREDITS", self)

func _pressed():
	pop_up.visible = true
