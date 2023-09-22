extends Node

@export var audio:AudioStreamPlayer = AudioStreamPlayer.new()

@onready var game_manager:Game_Manager = get_node("/root/Node2D/Systems/GameManager")
# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.on_victory.connect(_stop_audio)
	game_manager.on_defeat.connect(_stop_audio_b)
	game_manager.on_defeat_delay_needed.connect(_stop_audio_b)


func _stop_audio(arg):
	audio.stop()
	
func _stop_audio_b():
	audio.stop()

