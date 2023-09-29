class_name IfGameBlock extends GameBlock

@onready var game_manager:Game_Manager = get_node("/root/Node2D/Systems/GameManager")

@export var movement_prefab:Resource = Resource.new()
@export var spike_prefab:Resource = Resource.new()

func before_land_actions(player, gameblock):
	super(player, gameblock)

	var v = gameblock.get_subinstance()
	
	var inst 
	
	
	
	if v is MovementBlock:
		inst = movement_prefab.instantiate()
	else:
		inst = spike_prefab.instantiate()		
		
	inst.init(inst)

	gameblock.get_subinstance()._inst = inst
	#inst.set_extra_data(step)
	inst.position = gameblock.pos
	add_child(inst)
	

