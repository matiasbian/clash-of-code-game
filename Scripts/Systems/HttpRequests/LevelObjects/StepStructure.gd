class_name StepStructure

var steps = []
func _init(dataToParse):
	for elem in dataToParse.elements:
		var val = get_element(elem)
		steps.push_back(val)
		
func get_element(elem):
	var key = elem.keys()[0]
	if key == "movement":
		return MovementBlock.new(elem[key])
	elif key == "start":
		return StartBlock.new(elem[key])
	elif key == "finish":
		return FinishBlock.new(elem[key])
	
