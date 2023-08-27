class_name Spawner extends Node2D

@export var dirPrefab = Resource.new()
@export var startPrefab = Resource.new()
@export var finishPrefab = Resource.new()
@export var httpReq = HTTP_REQUESTS.new()

var level:LevelStructure

# Called when the node enters the scene tree for the first time.
func _ready():
	httpReq.data_retrieved.connect(instantiateLevel)
	
		
func instantiateLevel(data):
	print("Data retrieved")
	print(data)
	level = LevelStructure.new(data) 
	
	var i = 0
	for step in level.stepsList.steps:
		#TODO: Replace this with real blocks selection
		if (step is MovementBlock && step.dir == MovementBlock.Directions.Right):
			_instantiateBlock(i, dirPrefab)
		elif step is StartBlock:
			_instantiateBlock(i, startPrefab)
		elif step is FinishBlock:
			_instantiateBlock(i, finishPrefab)
		i += 1

	
func _instantiateBlock (multiplier, block):
	var inst = block.instantiate()
	add_child(inst)
	inst.position = Vector2(multiplier * 131, 0)

	
