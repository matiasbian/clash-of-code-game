class_name MovementBlock extends Node

enum Directions {Right, Left}
var dir:Directions

func _init(block):
	var direc:String = block["dir"]
	match direc:
		"Forward":
			dir = Directions.Right
		"Back":
			dir = Directions.Left
		_:
			dir = Directions.Left

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
