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
@export var error:Label = null
@export var loading:TextureRect = null

# Called when the node enters the scene tree for the first time.
func _ready():
	accept2_button.pressed.connect(accept2)
	accept_button.pressed.connect(_on_accept_clicked)
	cancel_button.pressed.connect(_on_cancel_clicked)
	HTTP.on_sign_up.connect(on_sign_up)
	
func _on_accept_clicked():
	_toggle_buttons(false)
	HTTP._sign_up(username.text, password.text)
	
func _on_cancel_clicked():
	visible = false
	login_pop_up.visible = true
	
func on_sign_up():
	_toggle_buttons(true)
	signup.visible = false
	verif.visible = true
	
func accept2():
	visible = false
	login_pop_up.visible = true
	
func _toggle_buttons(state):
	accept_button.disabled = !state
	accept2_button.disabled = !state
	loading.visible = !state
