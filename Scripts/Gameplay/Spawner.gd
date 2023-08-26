class_name Spawner extends Node2D

@export var prefab = Resource.new()
@export var httpReq = HTTP_REQUESTS.new()

var level:LevelStructure

# Called when the node enters the scene tree for the first time.
func _ready():
	httpReq.data_retrieved.connect(instantiateLevel)
	
		
func instantiateLevel(data):
	level = LevelStructure.new(data) 
	
	var i = 0
	for step in level.stepsList.steps:
		if (step.dir == MovementBlock.Directions.Right):
			InstantiateDirBlock(i)
		i += 1

func InstantiateDirBlock (multiplier):
	var inst = prefab.instantiate()
	add_child(inst)
	inst.position = Vector2(multiplier * 131, 0)

	
