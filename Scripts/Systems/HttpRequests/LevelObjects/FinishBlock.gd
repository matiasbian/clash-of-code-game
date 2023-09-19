class_name FinishBlock extends BaseGameBlock

var dir:MovementBlock.Directions

func _init(block):
	var direc:String = block
	match direc:
		"Forward":
			dir = MovementBlock.Directions.Right
		"Back":
			dir = MovementBlock.Directions.Left
		_:
			dir = MovementBlock.Directions.Left

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
