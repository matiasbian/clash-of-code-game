class_name HTTP_REQUESTS extends Node2D

@export var URL = "http://localhost:3000/api/levels?level=1"

signal data_retrieved(response)

func _ready():
	# Create an HTTP request node and connect its completion signal.
	HTTPget(URL)

	# Perform a POST request. The URL below returns JSON as of writing.
	# Note: Don't make simultaneous requests using a single HTTPRequest node.
	# The snippet below is provided for reference only.
	#var body = JSON.new().stringify({"name": "Godette"})
	#error = http_request.request("https://httpbin.org/post", [], HTTPClient.METHOD_POST, body)
	#if error != OK:
	#	push_error("An error occurred in the HTTP request.")
	
func HTTPget(url):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)

	# Perform a GET request. The URL below returns JSON as of writing.
	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request.")

# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
	print("Completed")
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()

	emit_signal("data_retrieved", response)
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	
