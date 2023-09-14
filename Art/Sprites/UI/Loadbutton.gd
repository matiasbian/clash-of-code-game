extends Button

@export var level:SpinBox = SpinBox.new()
@export var min_steps:SpinBox = SpinBox.new()
@export var label:TextEdit = TextEdit.new()
@export var structure:ItemList = ItemList.new()

	
func _pressed():
	level.value = 0
	min_steps.value = 0
	label.clear()
	structure.clear()
