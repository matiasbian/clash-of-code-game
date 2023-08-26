class_name StepStructure

var steps = []
func _init(dataToParse):
	for elem in dataToParse.elements:
		var val = get_element(elem)
		steps.push_front(val)
	print(steps[0].dir)
		
func get_element(elem):
	var key = elem.keys()[0]
	if key == "movement":
		return MovementBlock.new(elem["movement"])
	
