class_name Spawner extends Node2D

@export var dirPrefab = Resource.new()
@export var spikePrefab = Resource.new()
@export var startPrefab = Resource.new()
@export var finishPrefab = Resource.new()
@export var httpReq = HTTP_REQUESTS.new()

const GAME_MANAGER_PATH = "/root/Node2D/Systems/GameManager"
const BLOCKS_OFFSET = 130

var game_manager
var level:LevelStructure

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager = get_node(GAME_MANAGER_PATH)
	httpReq.data_retrieved.connect(instantiateLevel)
	
		
func instantiateLevel(data):
	level = LevelStructure.new(data) 
	
	var i = 0
	var blocks = []
	#start die block
	_instantiateBlock(-1, spikePrefab)	
	
	for step in level.stepsList.steps:
		blocks.push_back(step)
		#TODO: Replace this with real blocks selection
		if (step is MovementBlock && step.dir == MovementBlock.Directions.Right):
			_instantiateBlock(i, dirPrefab)
		elif step is StartBlock:
			_instantiateBlock(i, startPrefab)
		elif step is FinishBlock:
			_instantiateBlock(i, finishPrefab)
		i += 1
	#end die block
	_instantiateBlock(i, spikePrefab)	
	
	game_manager.SetBlocks(blocks)

	
func _instantiateBlock (multiplier, block):
	var inst = block.instantiate()
	add_child(inst)
	inst.position = Vector2(multiplier * BLOCKS_OFFSET, 0)
	
