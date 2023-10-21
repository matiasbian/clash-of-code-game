extends GutTest

var test_scene
var player
func before_each():
	
	test_scene = load("res://Scenes/Game.tscn").instantiate()
	player = test_scene.get_node("CharacterBody2D")
	
	var node2d = Node2D.new()
	node2d.name = "Node2D"
	get_node("/root/").add_child(node2d)
	
	var node2d2 = Node2D.new()
	node2d2.name = "Systems"
	node2d.add_child(node2d2)
	
	
	var target = node2d2
	var source = test_scene.get_child(4).get_child(1)
	test_scene.get_child(4).remove_child(source)
	target.add_child(source)
	source.set_owner(target)
	
	target = node2d2
	source = test_scene.get_child(4).get_child(0)
	test_scene.get_child(4).remove_child(source)
	target.add_child(source)
	source.set_owner(target)
	
	#@onready var game_manager:Game_Manager = get_node("/root/Node2D/Systems/GameManager")
	var c = get_node("/root/Node2D/Systems").get_children()
	
	add_child(test_scene)
	


func test_add_right_action_works():
	#player.movePlayerToPos(Vector2(10,10), false)
	var selected_commands = test_scene.get_node("UI/Panel/SelectedCommands/Panel/ColorRect/MarginContainer/ScrollContainer/HBoxContainer")
	var selected_commands_amount = selected_commands.get_child_count()
	add_movement_to_right()
	gut.simulate(player, 20, .1)
	assert_eq(selected_commands_amount + 1, selected_commands.get_child_count())
	
func add_movement_to_right():
	var right_button = test_scene.get_node("UI/Panel/AvailableCommands/ScrollContainer/VBoxContainer/Right/Button")
	right_button._pressed()
	

