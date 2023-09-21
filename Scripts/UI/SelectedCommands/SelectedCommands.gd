extends Node

const GAME_MANAGER_PATH = "/root/Node2D/Systems/GameManager"

@export var commandPrefab = Resource.new()
@export var container = HBoxContainer.new()

var game_manager
var currentIndex = 0

var list = []

func _ready():
	game_manager = get_node(GAME_MANAGER_PATH)
	game_manager.action_added.connect(_action_added)
	game_manager.action_removed.connect(_action_removed)
	game_manager.SetSelectedActionsReference(self)
	
func _action_added(action):
	var actLabel = action.get_parent().get_node("Button/Label")
	var actTex = action.get_parent().get_node("Button/TextureRect")
	
	var instance = commandPrefab.instantiate()
	var instanceLabel = instance.get_node("Button/Label")
	var instanceButton = instance.get_node("Button")
	var instanceTexture = instance.get_node("Button/TextureRect")
	
	instanceLabel.text = actLabel.text
	instanceLabel.visible = actLabel.visible
	
	instanceButton.index = currentIndex
	instanceButton.set_script(action.get_script())
	instanceButton.dir = action.dir
	
	instanceTexture.texture = actTex.texture
	instanceTexture.rotation = actTex.rotation
	
	container.add_child(instance)
	list.push_back(instance)
	instance.get_node("Button").index = list.size() -1
	
	
	instance.get_node("Button").isSideMenu = false

func _action_removed(index):
	var popped = list.pop_at(index)
	
	var i = 0
	for a in list:
		a.get_node("Button").index = i
		i+=1
	popped.queue_free()
	
	

