extends Button

@export var pop_up:Container = Container.new()
@export var trigger_auto:bool = true

@export var text_key = ""

var i18n = TextTo18n.new("ACCEPT", self)

func _ready():
	if (text_key != ""):
		TextTo18n.new(text_key, self)
	focus_mode = Control.FOCUS_NONE
	
func _pressed():
	if (!trigger_auto):
		return
		
	close()
	
func close():
	pop_up.visible = false
