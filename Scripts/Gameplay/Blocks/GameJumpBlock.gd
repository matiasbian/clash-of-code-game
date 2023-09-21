class_name JumpGameBlock extends GameBlock


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func init(step):
	var spikes = get_node("Spikes")
	for g in spikes.get_children():
		g.visible = false
	
	var dir = step.dir
	
	if dir == MovementBlock.Directions.Left:
		spikes.get_node("Left").visible = true
	elif dir == MovementBlock.Directions.Right:
		spikes.get_node("Right").visible = true
	elif dir == MovementBlock.Directions.Top:
		spikes.get_node("Top").visible = true
	elif dir == MovementBlock.Directions.Bottom:
		spikes.get_node("Bottom").visible = true
