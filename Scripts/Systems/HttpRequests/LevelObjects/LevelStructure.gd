class_name LevelStructure extends Node2D

var levelNumber:int
var label:String
var dialogs:String
var stepsList:StepStructure
var perfect_steps:int

func _init(dataToParse):	
	self.levelNumber = dataToParse["levelNumber"]
	self.label = dataToParse["label"]
	self.stepsList = StepStructure.new(dataToParse["structure"].elements)
	self.perfect_steps = dataToParse["perfectSteps"]
	
	if (dataToParse.has("dialogs") && dataToParse["dialogs"] is String):
		self.dialogs = dataToParse["dialogs"]
	
