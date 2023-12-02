class_name LevelsHTTP extends Node

@onready var http_requests:HTTP_REQUESTS = get_parent()

signal data_loaded(data)
signal post_signal(result, response_code)

var levels = []
# Called when the node enters the scene tree for the first time.
func _ready():
	http_requests.data_retrieved.connect(_store_levels_data)
	http_requests.data_sent.connect(_emit_post_signal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _store_levels_data(data):
	levels = data
	emit_signal("data_loaded", levels)
	
func remove_http(data):

	http_requests.HTTPPost("http://localhost:3000/api/remove-level", {"level": data})
	
func _emit_post_signal(response, response_code):
	emit_signal("post_signal", response, response_code)
