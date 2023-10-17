extends Panel

@export var label:Label = Label.new()
@export var button:Button = Button.new()
@onready var panel:Panel = get_node("Panel")

# Called when the node enters the scene tree for the first time.
func _ready():
	button.pressed.connect(exit)

func show_pop_up(text):
	panel.visible = true
	label.text = text
	
	
func exit():
	panel.visible = false
