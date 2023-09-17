class_name Spawner extends Node2D

@export var dirPrefab = Resource.new()
@export var jumpPrefab = Resource.new()
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
	var blocks:Dictionary
	var lastVector:Vector2 = Vector2(-BLOCKS_OFFSET * 2,0)
	
	#start die block
	lastVector = _instantiateBlock(lastVector, spikePrefab, MovementBlock.Directions.Right)	
	
	for step in level.stepsList.steps:
		#TODO: Replace this with real blocks selection
		if (step is MovementBlock):
			lastVector = _instantiateBlock(lastVector, dirPrefab, step.dir)
		elif (step is JumpBlock):
			lastVector = _instantiateBlock(lastVector, jumpPrefab, step.dir)
		elif step is StartBlock:
			lastVector = _instantiateBlock(lastVector, startPrefab, MovementBlock.Directions.Right)
		elif step is FinishBlock:
			lastVector = _instantiateBlock(lastVector, finishPrefab, step.dir)
		blocks[str(lastVector)] = step	
		i += 1
	#end die block
	lastVector = _instantiateBlock(lastVector, spikePrefab, MovementBlock.Directions.Right)	
	
	game_manager.SetBlocks(blocks)
	return blocks

	
func _instantiateBlock (lastPos, block, dir):
	var inst = block.instantiate()
	inst.init(dir)
	add_child(inst)
	inst.position = get_next_block_dir(dir, lastPos)
	return inst.position
	
func get_next_block_dir(dir, lastPos):
	if (dir == MovementBlock.Directions.Right):
		return lastPos + (Vector2.RIGHT * BLOCKS_OFFSET)
	elif  (dir == MovementBlock.Directions.Left):
		return lastPos + (Vector2.LEFT * BLOCKS_OFFSET)
	elif  (dir == MovementBlock.Directions.Top):
		return lastPos + (Vector2.UP * BLOCKS_OFFSET)
	elif  (dir == MovementBlock.Directions.Bottom):
		return lastPos + (Vector2.DOWN * BLOCKS_OFFSET)
	
