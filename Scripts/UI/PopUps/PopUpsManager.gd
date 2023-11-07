class_name PopUpManager extends Node

@onready var victory = get_node("Victory")
@onready var defeat = get_node("Defeat")
@onready var game_manager:Game_Manager = get_node("/root/Node2D/Systems/GameManager")
@onready var http_req:HTTP_REQUESTS = get_node("/root/Node2D/Systems/HttpRequests")
@onready var dialog:DialogPopUp = get_node("Dialog")

var there_is_next_level = false
var _no_reset_level = false

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.on_victory.connect(on_win)
	game_manager.on_defeat.connect(on_defeat)
	game_manager.on_defeat_delay_needed.connect(on_defeat_delay)
	
	http_req.data_sent.connect(level_ended)
	http_req.data_retrieved.connect(check_next_level)

func _show_dialog(message, level):
	dialog._show(message, level)

func on_defeat():
	get_node("/root/GlobalVar").play_lose()
	defeat.visible = true
	
func on_defeat_delay():
	await get_tree().create_timer(2.0).timeout
	get_node("/root/GlobalVar").play_lose()	
	defeat.visible = true
	defeat.setdata()
	
func on_win(percentage):
	await get_tree().create_timer(1.0).timeout
	victory.visible = true
	victory.setdata(percentage)
	
	_there_is_next_level()

func is_a_pop_up_open():
	var i = 0
	for p in get_children():
		if p.visible == true:
			i += 1
	return i > 1
	
	
func restart_level():
	get_node("/root/GlobalVar").play_tap()	
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	
func restart_game():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	
func level_ended(response, r_code):
	if (_no_reset_level):
		return
	
	if (there_is_next_level):
		next_level()
	else:
		restart_game()
	
func send_score(no_reset_level = false):
	get_node("/root/GlobalVar").play_tap()	
	var body = {
		"userID": 5,
		"levelNumber": get_node("/root/GlobalVar").level,
		"movements": game_manager.movementsExecuted
	}
	_no_reset_level = no_reset_level
	http_req.HTTPPost(http_req.URL_POST, body)
	
func next_level():
	get_node("/root/GlobalVar").level = get_node("/root/GlobalVar").level + 1
	restart_level()
	
func _there_is_next_level():
	var nextLvl = get_node("/root/GlobalVar").level + 1
	http_req.HTTPget(http_req.URL_GENERIC + str(nextLvl))
	
func check_next_level(data):
	there_is_next_level = data != null
	victory.check_next_level(there_is_next_level)
	
