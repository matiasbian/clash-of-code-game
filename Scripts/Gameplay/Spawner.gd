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
var blocks:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager = get_node(GAME_MANAGER_PATH)
	httpReq.data_retrieved.connect(instantiateLevel)
	
		
func instantiateLevel(data):
	level = LevelStructure.new(data) 
	
	var init = Vector2(-1 ,0)
	for step in level.stepsList.steps:
		_spawn_in_dir(step, step.pos)
	
	game_manager.SetBlocks(blocks)
	return blocks

func _spawn_in_dir(step, pos):
	var gamePos
	if (step is MovementBlock):
		gamePos = _instantiateBlock(step, dirPrefab)
	elif (step is JumpBlock):
		print("Step is JumpBlock")
		gamePos = _instantiateBlock(step, jumpPrefab)
	elif step is StartBlock:
		print("Step is StartBlock")
		gamePos = _instantiateBlock(step, startPrefab)
	elif step is FinishBlock:
		print("Step is FinishBlock")
		gamePos = _instantiateBlock(step, finishPrefab)
	blocks[str(gamePos)] = step	
	
func _instantiateBlock (step, block):
	var inst = block.instantiate()
	inst.init(step)
	add_child(inst)
	inst.position = get_next_block_dir(step.pos)
	return inst.position
	
func get_next_block_dir(pos):
	return pos * BLOCKS_OFFSET

	
