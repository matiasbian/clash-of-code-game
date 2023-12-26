class_name DialogPopUp extends Panel

@export var title:Label = Label.new()
@export var message:RichTextLabel = RichTextLabel.new()
@export var button:Button = Button.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	button.pressed.connect(_close)
	
func _show(dialog, level):
	if (!dialog):
		return
		
	visible = true
	title.text = "Nivel " + str(level)
	message.text = str(dialog) 
	
func _close():
	visible = false
	
