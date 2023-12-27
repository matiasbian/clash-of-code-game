class_name Spawner extends Node2D

@export var dirPrefab = Resource.new()
@export var jumpPrefab = Resource.new()
@export var spikePrefab = Resource.new()
@export var startPrefab = Resource.new()
@export var finishPrefab = Resource.new()
@export var ifPrefab = Resource.new()
@export var ballPrefab = Resource.new()
@export var ballPutPrefab = Resource.new()
@export var httpReq = HTTP_REQUESTS.new()

const GAME_MANAGER_PATH = "/root/Node2D/Systems/GameManager"
const BLOCKS_OFFSET = 130

var game_manager:Game_Manager
var level:LevelStructure
var blocks:Dictionary

var jumps:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager = get_node(GAME_MANAGER_PATH)
	httpReq.data_retrieved.connect(instantiateLevel)
	httpReq.get_current_level()
	
		
func instantiateLevel(data):
	if (data is Array):
		return
	
	level = LevelStructure.new(data)
	
	var init = Vector2(-1 ,0)
	for step in level.stepsList.steps:
		_spawn_in_dir(step, step.pos)
	
	game_manager.add_jumps(jumps)
	game_manager.SetBlocks(blocks)
	httpReq.data_retrieved.disconnect(instantiateLevel)
	return blocks

func _spawn_in_dir(step, pos):
	var gamePos
	var pref
	if (step is MovementBlock):
		pref = _instantiateBlock(step, jumpPrefab)		
		gamePos = _instantiateBlock(step, dirPrefab).position
	elif (step is JumpBlock):
		pref = _instantiateBlock(step, jumpPrefab)
		jumps += 1
		gamePos = pref.position
	elif step is StartBlock:
		pref = _instantiateBlock(step, startPrefab)
		gamePos = pref.position
	elif step is FinishBlock:
		pref =_instantiateBlock(step, finishPrefab)
		gamePos = pref.position
	elif step is IfBlock:
		pref = _instantiateBlock(step, ifPrefab)
		gamePos = pref.position
	elif step is BallBlock:
		pref = _instantiateBlock(step, ballPrefab)
		gamePos = pref.position
	elif step is PutBallBlock:
		pref = _instantiateBlock(step, ballPutPrefab)
		gamePos = pref.position
		
	step._inst = pref
	blocks[str(gamePos)] = step	
	
func _instantiateBlock (step, block):
	var inst = block.instantiate()
	inst.set_extra_data(step)
	inst.init(step)
	add_child(inst)
	inst.position = get_next_block_dir(step.pos)
	return inst
	
func get_next_block_dir(pos):
	return pos * BLOCKS_OFFSET

	
