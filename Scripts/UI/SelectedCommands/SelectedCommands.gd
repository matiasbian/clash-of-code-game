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
	var instance = commandPrefab.instantiate()
	instance.get_node("Label").text = action.get_parent().get_node("Label").text
	instance.get_node("Button").index = currentIndex
	instance.get_node("Button").dir = action.dir
	
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
	
	

