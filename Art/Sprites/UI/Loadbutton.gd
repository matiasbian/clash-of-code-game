extends Button

@export var level:SpinBox = SpinBox.new()
@export var min_steps:SpinBox = SpinBox.new()
@export var label:TextEdit = TextEdit.new()
@export var dialog:TextEdit = TextEdit.new()
@export var structure:ItemList = ItemList.new()

var i18n = TextTo18n.new("CANCEL", self)

	
func _pressed():
	level.value = 0
	min_steps.value = 0
	label.clear()
	dialog.clear()
	structure.clear()
