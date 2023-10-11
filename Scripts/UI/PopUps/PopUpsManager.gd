extends Node

@onready var victory = get_node("Victory")
@onready var defeat = get_node("Defeat")
@onready var game_manager:Game_Manager = get_node("/root/Node2D/Systems/GameManager")
@onready var http_req:HTTP_REQUESTS = get_node("/root/Node2D/Systems/HttpRequests")

@export var victory_next_level_button:Button = Button.new()
@export var victory_restart_level_button:Button = Button.new()
@export var victory_main_menu_button:Button = Button.new()

@onready var defeat_button:Button = get_node("Defeat/ColorRect/Button")


var there_is_next_level = false

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.on_victory.connect(on_win)
	game_manager.on_defeat.connect(on_defeat)
	game_manager.on_defeat_delay_needed.connect(on_defeat_delay)
	victory_next_level_button.button_up.connect(send_score)
	victory_restart_level_button.button_up.connect(restart_level)
	victory_main_menu_button.button_up.connect(restart_game)
	defeat_button.button_up.connect(restart_level)
	http_req.data_sent.connect(level_ended)
	http_req.data_retrieved.connect(check_next_level)


func on_defeat():
	get_node("/root/GlobalVar").play_lose()
	defeat.visible = true
	
func on_defeat_delay():
	await get_tree().create_timer(2.0).timeout
	get_node("/root/GlobalVar").play_lose()	
	defeat.visible = true
	
func on_win(percentage):
	await get_tree().create_timer(1.0).timeout
	victory.visible = true
	get_node("Victory/ColorRect/VBoxContainer/StarsContainer").setPerfectValues(percentage)
	
	_there_is_next_level()
	
	
func restart_level():
	get_node("/root/GlobalVar").play_tap()	
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	
func restart_game():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	
func level_ended(response):
	if (there_is_next_level):
		next_level()
	else:
		restart_game()
	
func send_score():
	get_node("/root/GlobalVar").play_tap()	
	var body = {
		"userID": 5,
		"levelNumber": get_node("/root/GlobalVar").level,
		"movements": game_manager.movementsExecuted
	}
	http_req.HTTPPost(http_req.URL_POST, body)
	
func next_level():
	get_node("/root/GlobalVar").level = get_node("/root/GlobalVar").level + 1
	restart_level()
	
func _there_is_next_level():
	var nextLvl = get_node("/root/GlobalVar").level + 1
	http_req.HTTPget(http_req.URL_GENERIC + str(nextLvl))
	
func check_next_level(data):
	there_is_next_level = data != null
	
