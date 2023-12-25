class_name HTTP_REQUESTS extends Node2D

@export var URL = "http://localhost:3000/api/levels?level=1"
var URL_GET_PROGRESS = "http://localhost:3000/api/progress?userID="
var URL_GENERIC = "http://localhost:3000/api/levels?level="
@export var URL_POST = "http://localhost:3000/api/progress"
@export var use_exported = false
@export var on_ready_call = true

signal data_retrieved(response)
signal data_sent(response, response_code)

signal on_login(body)
signal on_sign_up()

func _ready():
	# Create an HTTP request node and connect its completion signal.
	var lvl = get_node("/root/GlobalVar").level
	var url
	
	if (on_ready_call):
		if use_exported:
			url = URL
		else:
			url = URL_GENERIC + str(lvl)
		
	on_login.connect(on_login_successful)
	
	if (GlobalVar.user_email != ""):
		on_login_successful(null)
	#_log_in('un_email1@gmail.com', "Rqasd3313saaa##")
	#_log_in('matiasezequielbian@gmail.com', "123456")

func get_current_level():
	var url = URL_GENERIC + str(GlobalVar.level)
	HTTPget(url)
	
func on_login_successful(VAR):
	HTTPget(URL_GET_PROGRESS + GlobalVar.user_email)
	
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
		
func HTTPPost(url, body, callback = null):
	# Convert data to json string:
	var query = JSON.stringify(body)

	# Add 'Content-Type' header:
	var headers
	headers = ["Content-Type: application/json", "Access-Control-Allow-Origin: *"]
	
	var http_request = HTTPRequest.new()
	add_child(http_request)

	http_request.request(url, headers, HTTPClient.METHOD_POST, query)

	if (callback):
		http_request.request_completed.connect(callback)
	else:
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
	
func _supabase_call(path, body, callback):
	HTTPPost("http://localhost:3000/api/" + path,  body, callback)

func _sign_up(_email, _password):
	var body = {
		'email': _email, 
		'password': _password
	}
	_supabase_call('/signUp', body, _on_sign_up_completed)
	
func _log_in(_email, _password):
	var body = {
		'email': _email, 
		'password': _password,
	}
	_supabase_call('/login', body, _on_log_in_completed)	


func _on_sign_up_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	emit_signal("on_sign_up")
	
	
func _on_log_in_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	
	if (response.user):
		GlobalVar.user_email = response.user.email
	emit_signal("on_login", response)
