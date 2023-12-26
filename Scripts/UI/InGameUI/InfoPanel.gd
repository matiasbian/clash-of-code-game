extends Control

@export var level:Label = Label.new()
@export var time:Label = Label.new()
@export var steps:Label = Label.new()

@export var tuto_script:TutorialUI = TutorialUI.new()

@onready var game_manager:Game_Manager = get_node("/root/Node2D/Systems/GameManager")
var _timer

# Called when the node enters the scene tree for the first time.
func _ready():
	level.text = tr("LEVEL") + ": " + str(get_node("/root/GlobalVar").level)
	
	game_manager.on_step_performed.connect(set_step)
	
	_timer = Timer.new()
	add_child(_timer)
	_timer.timeout.connect(_on_timer_timeout)
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()
	

func set_step(step_n, total):
	steps.text = tr("STEPS") + " %d/%d" % [step_n, total]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_timer_timeout():
	time.text =  tr("TIME") + " " + game_manager.time_manager.get_time_formatted()

