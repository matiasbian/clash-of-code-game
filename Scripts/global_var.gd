extends Node

var level:int = 1
var tuto_completed = false
var tuto_skipped = false

enum Screens {NULL, Game, LevelEditor, Menu}
var prev_screen = Screens.NULL

@onready var sfx_button_add =  load("res://Art/Sfx/add_button.wav")
@onready var sfx_remove_add =  load("res://Art/Sfx/remove_button.wav")
@onready var sfx_walk =  load("res://Art/Sfx/walk.wav")
@onready var sfx_explosion =  load("res://Art/Sfx/explosion.wav")
@onready var sfx_jump =  load("res://Art/Sfx/jump.wav")
@onready var sfx_tap =  load("res://Art/Sfx/tap.wav")
@onready var sfx_win =  load("res://Art/Sfx/win.wav")
@onready var sfx_lose =  load("res://Art/Sfx/lose.wav")
@onready var sfx_start_game =  load("res://Art/Sfx/start_game.wav")
@onready var sfx_play_comnmand =  load("res://Art/Sfx/play_commands.mp3")

@onready var audio_player:AudioStreamPlayer = AudioStreamPlayer.new()

func _ready():
	add_child(audio_player)	
	audio_player.volume_db = -11

func play_audio_add_button():
	audio_player.stream = sfx_button_add
	_play()
	
func play_audio_remove_button():
	audio_player.stream = sfx_remove_add
	_play()
	
func play_step():
	audio_player.stream = sfx_walk
	_play(0)
	
func play_explosion():
	audio_player.stream = sfx_explosion
	_play()

func play_jump():
	audio_player.stream = sfx_jump
	_play()
	
func play_tap():
	audio_player.stream = sfx_tap
	_play()
	
func play_win():
	audio_player.stream = sfx_win
	_play()
	
func play_lose():
	audio_player.stream = sfx_lose
	_play()
	
func play_commands():
	audio_player.stream = sfx_play_comnmand
	_play(-5)
	
func play_start_game():
	audio_player.stream = sfx_start_game
	_play(-5)
	
func _play(volume = -11):
	audio_player.volume_db = volume
	audio_player.play()
	
