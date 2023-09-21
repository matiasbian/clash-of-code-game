class_name GridButtonSpawner extends GridContainer

@export var button_prefab:Resource = Resource.new()


var SIZE = 5

func _ready():
	spawn()
	
	#var target = (SIZE * 2)
	#_get_cell(target)._change_type()
	
func spawn():
	var l = SIZE * SIZE
	
	for i in range(0, l):
		var OFFSET = (SIZE / 2)
		var row = (i / SIZE) - OFFSET
		var col = i % SIZE
		
		var inst = button_prefab.instantiate()
		inst.set_pos(Vector2(col,row))
		add_child(inst)
		
func set_sized(size):
	SIZE = size
	
func _reset():
	for c in get_children():
		remove_child(c)
	
func resize(size):
	SIZE = size
	columns = SIZE
	
	_reset()
	spawn()
	
func _grid_to_elem(pos):
	return pos.x + (pos.y * SIZE)
	
func _get_cell(pos):
	return get_child(pos)
