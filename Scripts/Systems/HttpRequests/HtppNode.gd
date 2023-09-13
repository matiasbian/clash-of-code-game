class_name HTTP_REQUESTS extends Node2D

@export var URL = "http://localhost:3000/api/levels?level=1"
@export var URL_POST = "http://localhost:3000/api/progress"

signal data_retrieved(response)
signal data_sent(response)

func _ready():
	# Create an HTTP request node and connect its completion signal.
	HTTPget(URL)
	
func HTTPget(url):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)
	
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
	print("Response " + str(response_code))
	emit_signal("data_sent", result)

# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
	print("Completed")
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()

	emit_signal("data_retrieved", response)
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	
