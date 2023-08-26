class_name LevelStructure extends Node2D

var levelNumber:int
var label:String
var stepsList

func _init(dataToParse):
	self.levelNumber = dataToParse["levelNumber"]
	self.label = dataToParse["label"]
	self.stepsList = StepStructure.new(dataToParse["structure"])
	
