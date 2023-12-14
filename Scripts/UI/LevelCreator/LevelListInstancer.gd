extends ItemList

@export var data:LevelsHTTP = LevelsHTTP.new()
@export var accept_button:Button = Button.new()
@export var cancel_button:Button = Button.new()
@export var pop_up:Panel = Panel.new()
@export var pop_up_error:Panel = Panel.new()
@export var cancel_error:Button = Button.new()

var selected_index
# Called when the node enters the scene tree for the first time.
func _ready():
	data.data_loaded.connect(_data_loaded)
	accept_button.pressed.connect(_delete_level)
	cancel_button.pressed.connect(_cancel)
	cancel_error.pressed.connect(_cancel_error)
	data.post_signal.connect(_on_post)
	
	
func _data_loaded(data):
	for d in data:
		add_item(tr("LEVEL") + " " + str(d.level))
		
func _delete_level():
	if (get_selected_items().size() == 0):
		return
	
	var item:String = get_item_text(get_selected_items()[0])
	item = item.trim_prefix(tr("LEVEL") + " ")
	data.remove_http(item)
	
func _cancel():
	pop_up.visible = false
	
func _cancel_error():
	pop_up_error.visible = false
	
func _on_post(result, response_code):
	if response_code >= 400:
		print("There is an error: " + str(result))
		pop_up_error.visible = true
		return
	remove_item(get_selected_items()[0])	
	
