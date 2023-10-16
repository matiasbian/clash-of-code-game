extends Node

@export var next_level_button:Button = Button.new()
@export var restart_level_button:Button = Button.new()
@export var main_menu_button:Button = Button.new()

@export var title_label:Label = Label.new()
@export var time_label:Label = Label.new()
@export var steps_label:Label = Label.new()

@export var pop_up_manager:PopUpManager = PopUpManager.new()

const title = "NIVEL %s completado"

# Called when the node enters the scene tree for the first time.
func _ready():
	next_level_button.button_up.connect(pop_up_manager.send_score)
	restart_level_button.button_up.connect(pop_up_manager.restart_level)
	main_menu_button.button_up.connect(pop_up_manager.restart_game)
	

func setdata(percentage):
	var level = get_node("/root/GlobalVar").level
	title_label.text = title % level
	get_node("ColorRect/VBoxContainer/StarsContainer").setPerfectValues(percentage)
	
	time_label.text = pop_up_manager.game_manager.time_manager.get_time_formatted()
	steps_label.text = str(pop_up_manager.game_manager.movementsExecuted) + " / " + str(pop_up_manager.game_manager.perfect_steps)

func check_next_level(there_is):
	next_level_button.visible = there_is
