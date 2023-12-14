extends RichTextLabel

@export var key:String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	text = tr(key)
