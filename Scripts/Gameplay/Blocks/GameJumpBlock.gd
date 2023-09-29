class_name JumpGameBlock extends GameBlock


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func init(step):
	super(step)
	step_class.before_check.connect(before_check)
	
func before_check(inst):
	var spikes = get_node("Spikes")
	for g in spikes.get_children():
		g.visible = false
	
	
