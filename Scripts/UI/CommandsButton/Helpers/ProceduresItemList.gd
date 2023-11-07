class_name ProcedureItemList extends ItemList

var procedures:Array = []
var selected_proc

@export var add_buton:Button = Button.new()
@export var remove_buton:Button = Button.new()
@export var selected_commands:SelectedCommands = SelectedCommands.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	item_selected.connect(_on_selected)
	selected_commands.procedure_added.connect(add_elem)
	remove_buton.pressed.connect(_remove_elem)

func refresh_list():
	clear()
	for elem in procedures:
		add_item(elem.proc_picked.proc_name)

func add_elem(elem):
	procedures.push_back(elem)
	add_item(elem.proc_picked.proc_name)
	print(procedures.size())
	
func _remove_elem():
	var index = get_selected_items()[0]
	selected_commands.procedure_removed
	procedures.remove_at(index)
	remove_item(index)
	selected_commands._procedure_removed(index)
	
func reset():
	procedures.clear()
	
	for elem in get_children():
		elem.queue_free()
		
func _on_selected(index):
	selected_proc = procedures[index]
