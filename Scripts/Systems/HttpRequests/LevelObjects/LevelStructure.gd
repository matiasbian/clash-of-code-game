class_name LevelStructure extends Node2D

var levelNumber:int
var label:String
var stepsList:StepStructure
var perfect_steps:int

func _init(dataToParse):
	print(dataToParse)
	self.levelNumber = dataToParse["levelNumber"]
	self.label = dataToParse["label"]
	self.stepsList = StepStructure.new(dataToParse["structure"].elements, "")
	self.perfect_steps = dataToParse["perfectSteps"]
	
