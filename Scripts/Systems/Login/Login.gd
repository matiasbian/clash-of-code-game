extends Panel

@export var register_pop_up = Panel.new()
@export var HTTP = HTTP_REQUESTS.new()

@export var register_button:Button = null
@export var accept_button:Button = null
@export var username:LineEdit = null
@export var password:LineEdit = null

@export var parent_container:Panel = null
# Called when the node enters the scene tree for the first time.
func _ready():
	if (GlobalVar.user_email != ""):
		parent_container.visible = false
		
	accept_button.pressed.connect(_on_accept_clicked)
	register_button.pressed.connect(_on_register_clicked)
	HTTP.on_login.connect(on_login)
	
	
func _on_accept_clicked():
	HTTP._log_in(username.text, password.text)
	
func _on_register_clicked():
	visible = false
	register_pop_up.visible = true
	
func on_login(response):
	if (!response.user):
		return
	parent_container.visible = false

