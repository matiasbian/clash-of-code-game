class_name SelectedCommands extends Node

signal procedure_added(procedure)
signal procedure_removed(index)

const GAME_MANAGER_PATH = "/root/Node2D/Systems/GameManager"

@export var commandPrefab = Resource.new()
@export var container = HBoxContainer.new()
@export var container_procedures = HBoxContainer.new()

var game_manager
var currentIndex = 0

var list = []
var list_procedures = []
var temp_list = []

func _ready():
	game_manager = get_node(GAME_MANAGER_PATH)
	game_manager.action_added.connect(_action_added)
	game_manager.action_removed.connect(_action_removed)
	game_manager.procedure_added.connect(_procedure_added)
	game_manager.SetSelectedActionsReference(self)
	
func _procedure_added(procedure):
	_instance_and_add(procedure, true)
	
func _procedure_removed(index):
	var popped = list_procedures.pop_at(index)
	
	var i = 0
	for a in list_procedures:
		a.get_node("Button").index = i
		i+=1
	popped.queue_free()
	
func _action_added(action):
	_instance_and_add(action, false)

func _instance_and_add(action, is_procedure):
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
	instanceButton.set_extra_values(action)
	
	instanceTexture.texture = actTex.texture
	instanceTexture.rotation = actTex.rotation
	
	if (!is_procedure):
		container.add_child(instance)
		list.push_back(instance)
		instance.get_node("Button").index = list.size() -1
	else:
		container_procedures.add_child(instance)
		list_procedures.push_back(instance)
		instance.get_node("Button").index = list_procedures.size() -1
		emit_signal("procedure_added", instance.get_node("Button"))
	get_node("/root/GlobalVar").play_audio_add_button()		
	instance.get_node("Button").isSideMenu = false
	
func _action_removed(index):
	var popped = list.pop_at(index)
	
	var i = 0
	for a in list:
		a.get_node("Button").index = i
		i+=1
	popped.queue_free()
	
	
	

