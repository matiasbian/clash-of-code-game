extends Panel

@export var login_pop_up = Panel.new()
@export var verif = VBoxContainer.new()
@export var signup = VBoxContainer.new()
@export var HTTP = HTTP_REQUESTS.new()

@export var cancel_button:Button = null
@export var accept_button:Button = null
@export var accept2_button:Button = null
@export var username:LineEdit = null
@export var password:LineEdit = null

# Called when the node enters the scene tree for the first time.
func _ready():
	accept2_button.pressed.connect(accept2)
	accept_button.pressed.connect(_on_accept_clicked)
	cancel_button.pressed.connect(_on_cancel_clicked)
	HTTP.on_sign_up.connect(on_sign_up)
	
func _on_accept_clicked():
	HTTP._sign_up(username.text, password.text)
	
func _on_cancel_clicked():
	visible = false
	login_pop_up.visible = true
	
func on_sign_up():
	signup.visible = false
	verif.visible = true
	
func accept2():
	visible = false
	login_pop_up.visible = true
