extends Node

@onready var victory = get_node("Victory")
@onready var defeat = get_node("Defeat")
@onready var game_manager = get_node("/root/Node2D/Systems/GameManager")

@onready var victory_button:Button = get_node("Victory/ColorRect/Button")
@onready var defeat_button:Button = get_node("Defeat/ColorRect/Button")

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.on_victory.connect(on_win)
	game_manager.on_defeat.connect(on_defeat)
	victory_button.button_up.connect(send_score)
	defeat_button.button_up.connect(restart_level)


func on_defeat():
	defeat.visible = true
	
func on_win():
	victory.visible = true
	
func restart_level():
	get_tree().reload_current_scene()
	
func send_score():
	print("TODO: implement start level feature")
	restart_level()
