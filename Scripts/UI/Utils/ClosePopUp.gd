extends Button

@export var pop_up:Container = Container.new()
@export var trigger_auto:bool = true

func _ready():
	focus_mode = Control.FOCUS_NONE
	
func _pressed():
	if (!trigger_auto):
		return
		
	close()
	
func close():
	pop_up.visible = false
