class_name StepStructure

#var steps = []

var nodeTop:StepStructure
var nodeForward:StepStructure
var nodeBackward:StepStructure
var nodeBottom:StepStructure

var node_value:BaseGameBlock
var node_key:String

func _init(dataToParse, dir):
	#for elem in dataToParse.elements:
	#	var val = get_element(elem)
	#	steps.push_back(val)
	#	
	#New
	
	if (!dataToParse.has("value")):
		return
		
	node_value = get_element(dataToParse["value"], dir)
	node_key = dataToParse["value"]["type"]
	
	nodeTop = StepStructure.new(dataToParse.nodeTop, "Top")
	nodeForward = StepStructure.new(dataToParse.nodeForward, "Forward")
	nodeBackward = StepStructure.new(dataToParse.nodeBackward, "Backward")
	nodeBottom = StepStructure.new(dataToParse.nodeBottom, "Bottom")
	
		
func get_element(elem, dir):
	#var key = elem.keys()[0]
	#new
	var key = elem
	print("Key is " + str(key))
	if key["type"] == "Movement":
		return MovementBlock.new(dir)
	elif key["type"] == "Start":
		return StartBlock.new()
	elif key["type"] == "Jump":
		return JumpBlock.new(dir)
	elif key["type"] == "Finish":
		return FinishBlock.new(dir)
	
func _to_string():
	var val = ""
	
	if (node_value != null):
		val = node_key
	else:
		return ""
		
	return "------------------->>>>\n Tree: value: " + val + "\n" + "top: " + str(nodeTop) + "\n" + "bot: " + str(nodeBottom) + "\n" + "right: " + str(nodeForward) + "\n" + "left: " + str(nodeBackward)
