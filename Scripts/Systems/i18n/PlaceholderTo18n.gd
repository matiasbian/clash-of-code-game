extends LineEdit

@export var key:String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	placeholder_text = tr(key)

	
