extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var httpNode:HTTP_REQUESTS = get_tree().root.get_node("MainMenu/HtppNode")
	httpNode.data_retrieved.connect(_fillLevelInfo)
	
func _fillLevelInfo(data):
	get_child(0).setData(data)
