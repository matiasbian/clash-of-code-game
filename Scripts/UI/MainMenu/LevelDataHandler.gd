extends Control

@export var levelThumbnail:Resource = Resource.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var httpNode:HTTP_REQUESTS = get_tree().root.get_node("MainMenu/HtppNode")
	httpNode.data_retrieved.connect(_fillLevelInfo)
	
func _fillLevelInfo(data):
	for d in data:
		var inst = levelThumbnail.instantiate()
		add_child(inst)
		print(d)
		inst.setData(d)
