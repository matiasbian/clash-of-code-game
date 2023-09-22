extends Control

@export var levelThumbnail:Resource = Resource.new()
@export var back:Button = Button.new()

@export var main_menu:Container = Container.new()

var httpNode:HTTP_REQUESTS 
var tempData
# Called when the node enters the scene tree for the first time.
func _ready():
	httpNode = get_tree().root.get_node("MainMenu/HtppNode")
	httpNode.HTTPgetWithCallback("http://localhost:3000/api/alllevels", _add_levels)	
	
	httpNode.data_retrieved.connect(saveData)
	back.pressed.connect(_back)
	
func _add_levels(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var res = json.get_data()
	for d in res:
		var inst = levelThumbnail.instantiate()
		add_child(inst)
		inst.setLevel(d)
	_fillLevelInfo(tempData)
	

func saveData(data):
	print("temp data " + str(data))
	tempData = data
		
func _fillLevelInfo(data):
	if (!data):
		return

	for d in data:
		get_child(d.levelNumber -1).setData(d)
		
func _back():
	get_parent().visible = false
	main_menu.visible = true
