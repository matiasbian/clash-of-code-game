extends Button

@export var manage_levels:Panel = Panel.new()

var i18n = TextTo18n.new("LEVELS_CREATED", self)

func _pressed():
	manage_levels.visible = true
