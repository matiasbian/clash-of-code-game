extends Node

@export var restart_level_button:Button = Button.new()
@export var main_menu_button:Button = Button.new()

#@export var title_label:Label = Label.new()
@export var time_label:Label = Label.new()
@export var steps_label:Label = Label.new()

@export var pop_up_manager:PopUpManager = PopUpManager.new()

const title = "NIVEL %s completado"

# Called when the node enters the scene tree for the first time.
func _ready():
	restart_level_button.button_up.connect(pop_up_manager.restart_level)
	main_menu_button.button_up.connect(pop_up_manager.restart_game)
	

func setdata():
	var level = get_node("/root/GlobalVar").level
	#title_label.text = title % level
	
	time_label.text = pop_up_manager.game_manager.time_manager.get_time_formatted()
	steps_label.text = str(pop_up_manager.game_manager.movementsExecuted) + " / " + str(pop_up_manager.game_manager.perfect_steps)
	
