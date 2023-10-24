class_name StepStructure

var steps = []

func _init(dataToParse):
	for elem in dataToParse:
		var val = get_element(elem)
		steps.push_back(val)
		
		
func get_element(elem):
	var key = elem["type"]
	if key == "movement":
		return MovementBlock.new(elem)
	elif key == "start":
		return StartBlock.new(elem)
	elif key == "jump":
		return JumpBlock.new(elem)
	elif key == "finish":
		return FinishBlock.new(elem)
	elif key == "if":
		return IfBlock.new(elem)
	elif key == "ball":
		return BallBlock.new(elem)
	
