extends Node

var level:int = 1

@onready var sfx_button_add =  load("res://Art/Sfx/add_button.wav")
@onready var sfx_remove_add =  load("res://Art/Sfx/remove_button.wav")
@onready var sfx_walk =  load("res://Art/Sfx/walk.wav")
@onready var sfx_explosion =  load("res://Art/Sfx/explosion.wav")
@onready var sfx_jump =  load("res://Art/Sfx/jump.wav")
@onready var sfx_tap =  load("res://Art/Sfx/tap.wav")
@onready var sfx_win =  load("res://Art/Sfx/win.wav")
@onready var sfx_lose =  load("res://Art/Sfx/lose.wav")

@onready var audio_player:AudioStreamPlayer = AudioStreamPlayer.new()

func _ready():
	add_child(audio_player)
	audio_player.volume_db = -11

func play_audio_add_button():
	audio_player.stream = sfx_button_add
	audio_player.play()
	
func play_audio_remove_button():
	audio_player.stream = sfx_remove_add
	audio_player.play()
	
func play_step():
	audio_player.stream = sfx_walk
	audio_player.play()
	
func play_explosion():
	audio_player.stream = sfx_explosion
	audio_player.play()

func play_jump():
	audio_player.stream = sfx_jump
	audio_player.play()
	
func play_tap():
	audio_player.stream = sfx_tap
	audio_player.play()
	
func play_win():
	audio_player.stream = sfx_win
	audio_player.play()
	
func play_lose():
	audio_player.stream = sfx_lose
	audio_player.play()
