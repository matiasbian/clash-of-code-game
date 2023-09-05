extends Node

@onready var victory = get_node("Victory")
@onready var defeat = get_node("Defeat")
@onready var game_manager:Game_Manager = get_node("/root/Node2D/Systems/GameManager")
@onready var http_req:HTTP_REQUESTS = get_node("/root/Node2D/Systems/HttpRequests")

@onready var victory_button:Button = get_node("Victory/ColorRect/Button")
@onready var defeat_button:Button = get_node("Defeat/ColorRect/Button")

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.on_victory.connect(on_win)
	game_manager.on_defeat.connect(on_defeat)
	game_manager.on_defeat_delay_needed.connect(on_defeat_delay)
	victory_button.button_up.connect(send_score)
	defeat_button.button_up.connect(restart_level)
	http_req.data_sent.connect(level_ended)


func on_defeat():
	defeat.visible = true
	
func on_defeat_delay():
	await get_tree().create_timer(2.0).timeout
	defeat.visible = true
	
func on_win():
	victory.visible = true
	
func restart_level():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	
func level_ended(response):
	restart_level()
	
func send_score():
	var body = {
		"userID": 5,
		"levelNumber": 1,
		"movements": game_manager.movementsExecuted
	}
	http_req.HTTPPost(http_req.URL_POST, body)
