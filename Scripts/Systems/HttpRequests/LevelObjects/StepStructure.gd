class_name StepStructure

var steps = []

func _init(dataToParse):
	for elem in dataToParse:
		var val = get_element(elem)
		steps.push_back(val)
		
		
func get_element(elem):
	#var key = elem.keys()[0]
	print("----elem----")
	print(elem)
	#new
	var key = elem["type"]
	print("Key is " + str(key))
	if key == "movement":
		return MovementBlock.new(elem)
	elif key == "start":
		return StartBlock.new(elem)
	elif key == "jump":
		return JumpBlock.new(elem)
	elif key == "finish":
		return FinishBlock.new(elem)
	
