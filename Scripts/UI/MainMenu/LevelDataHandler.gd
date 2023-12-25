extends Control

@export var levelThumbnail:Resource = Resource.new()
@export var back:Button = Button.new()

@export var main_menu:Container = Container.new()

var httpNode:HTTP_REQUESTS
var tempData
# Called when the node enters the scene tree for the first time.
func _ready():
	httpNode = get_tree().root.get_node("MainMenu/HtppNode")
	httpNode.data_retrieved.connect(saveData)
	back.pressed.connect(_back)
	
func _add_levels(result, response_code, headers, body):
	if (GlobalVar.user_email == ""):
		return
		
	print("add level")
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var res = json.get_data()
	for d in res:
		var inst = levelThumbnail.instantiate()
		add_child(inst)
		inst.setLevel(d)
		
	_fillLevelInfo(tempData)
	if (GlobalVar.prev_screen == GlobalVar.Screens.Game):
		GlobalVar.prev_screen = GlobalVar.Screens.NULL
		get_parent().get_parent().get_parent().visible = true
		
	

func saveData(data):
	
	tempData = data
	httpNode.HTTPgetWithCallback("http://localhost:3000/api/alllevels", _add_levels)	
	
		
func _fillLevelInfo(data):
	if (!data):
		return
	
	if (data is Array):
		var i = 0
		for d in data:
			if get_child_count() < d.levelNumber:
				return
			
			get_child(d.levelNumber -1).setData(d)
			i += 1
		
		if (get_child_count() >= i):
			var child = get_child(i)
			if (child):
				get_child(i).unlock()
	else:
		get_child(data.levelNumber -1).setData(data)
		
func _back():
	get_parent().get_parent().get_parent().visible = false
	main_menu.visible = true
