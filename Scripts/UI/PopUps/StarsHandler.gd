extends Control

@export var completedTexture:Texture = Texture.new()
@export var emptyTexture:Texture = Texture.new()


func setPerfectValues(percentage, anim = true):
	var val = 0
	if percentage >= 100:
		val = 3
	elif percentage >= 60:
		val = 2
	else:
		val = 1
	set_stars(val, anim)
		
func set_stars(val, anim):
	var childN = get_child_count()
	for j in range(0, childN):
		if (j < val):
			get_child(j).get_node("star").texture = null
		else:
			get_child(j).get_node("AnimationPlayer").play("Idle")			
			

				
	for i in range(0,val):
		get_child(i).get_node("star").texture = completedTexture
		if (anim):
			get_child(i).get_node("AnimationPlayer").play("PopUp")
		else:
			get_child(i).get_node("AnimationPlayer").play("Idle")
		await get_tree().create_timer(0.3).timeout

	
