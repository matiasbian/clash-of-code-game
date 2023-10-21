extends GutTest

var test_scene
func before_each():
	
	test_scene = load("res://Scenes/MainMenu.tscn").instantiate()
	
	var node2d = Node2D.new()
	node2d.name = "MainMenu"
	get_node("/root/").add_child(node2d)
	
	var node2d2 = HTTP_REQUESTS.new()
	node2d2.URL = "http://localhost:3000/api/progress?userID=5"
	node2d2.use_exported = true
	node2d2.name = "HtppNode"
	node2d.add_child(node2d2)
	
	
	add_child(test_scene)
	
	

func test_play_button():
	var children = get_node("/root/").get_children()
	
	var play_btn = test_scene.get_node("UI/MainMenu/Panel/Panel/LeftSide/VBoxContainer/Button")
	play_btn.MainMenu = test_scene.get_node("UI/MainMenu")
	play_btn.LevelsMenu = test_scene.get_node("UI/Levels")
	play_btn._pressed()
	
	var grid_container = test_scene.get_node("UI/Levels/GridContainer")
	await get_tree().create_timer(1).timeout	
	var grid_container_child_n = grid_container.get_child_count()
	assert_eq(true  ,grid_container_child_n >= 1, "Failed")
	

