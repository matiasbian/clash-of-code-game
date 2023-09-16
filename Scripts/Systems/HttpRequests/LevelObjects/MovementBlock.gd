class_name MovementBlock extends BaseGameBlock

enum Directions {NULL, Right, Left, Top, Bottom}
var dir:Directions

func _init(block):
	var direc:String = block["dir"]
	match direc:
		"Forward":
			dir = Directions.Right
		"Back":
			dir = Directions.Left
		"Top":
			dir = Directions.Top
		"Bottom":
			dir = Directions.Bottom
		_:
			dir = Directions.Left

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
