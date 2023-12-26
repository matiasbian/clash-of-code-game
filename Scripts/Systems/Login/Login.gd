extends Panel

@export var register_pop_up = Panel.new()
@export var HTTP = HTTP_REQUESTS.new()

@export var register_button:Button = null
@export var accept_button:Button = null
@export var username:LineEdit = null
@export var password:LineEdit = null
@export var error:Label = null
@export var loading:TextureRect = null

@export var parent_container:Panel = null

var ERROR_MSG = "USER_OR_PASS"
# Called when the node enters the scene tree for the first time.
func _ready():
	if (GlobalVar.user_email != ""):
		parent_container.visible = false
		
	accept_button.pressed.connect(_on_accept_clicked)
	register_button.pressed.connect(_on_register_clicked)
	HTTP.on_login.connect(on_login)
	
	
func _on_accept_clicked():
	_toggle_buttons(false)
	HTTP._log_in(username.text, password.text)
	
func _on_register_clicked():
	visible = false
	register_pop_up.visible = true
	
func on_login(response):
	_toggle_buttons(true)
	
	if (!response.user):
		error.text = tr(ERROR_MSG)
		return
		
	parent_container.visible = false
	
func _toggle_buttons(state):
	accept_button.disabled = !state
	register_button.disabled = !state
	loading.visible = !state
	
	

