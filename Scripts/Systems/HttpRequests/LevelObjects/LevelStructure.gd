class_name LevelStructure extends Node2D

var levelNumber:int
var label:String
var stepsList
var perfect_steps:int

func _init(dataToParse):
	self.levelNumber = dataToParse["levelNumber"]
	self.label = dataToParse["label"]
	self.stepsList = StepStructure.new(dataToParse["structure"])
	self.perfect_steps = dataToParse["perfectSteps"]
	
