class_name HTTP_REQUESTS extends Node2D

@export var URL = "http://localhost:3000/api/levels?level=1"
var URL_GENERIC = "http://localhost:3000/api/levels?level="
@export var URL_POST = "http://localhost:3000/api/progress"
@export var use_exported = false

signal data_retrieved(response)
signal data_sent(response, response_code)

func _ready():
	# Create an HTTP request node and connect its completion signal.
	var lvl = get_node("/root/GlobalVar").level
	var url
	if use_exported:
		url = URL
	else:
		url = URL_GENERIC + str(lvl)
	HTTPget(url)
	
func HTTPget(url):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)
	
	var headers = ["Access-Control-Allow-Origin: *"]
	# Perform a GET request. The URL below returns JSON as of writing.
	var error = http_request.request(url, headers)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
		
func HTTPgetWithCallback(url, callback):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(callback)
	
	var headers = ["Access-Control-Allow-Origin: *"]
	# Perform a GET request. The URL below returns JSON as of writing.
	var error = http_request.request(url, headers)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
		
func HTTPPost(url, body):
	# Convert data to json string:
	var query = JSON.stringify(body)

	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json", "Access-Control-Allow-Origin: *"]
	
	
	var http_request = HTTPRequest.new()
	add_child(http_request)

	http_request.request(url, headers, HTTPClient.METHOD_POST, query)

	http_request.request_completed.connect(data_sent_f)
	

	
func data_sent_f(result, response_code, headers, body):
	emit_signal("data_sent", result, response_code)

# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()

	emit_signal("data_retrieved", response)
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	
