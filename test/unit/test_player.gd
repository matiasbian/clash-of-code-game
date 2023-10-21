extends GutTest

func test_assert_eq_initial_pos():
	var player = Player.new()
	var anim = AnimationPlayer.new()
	anim.name = "AnimationPlayer"
	player.add_child(anim)

	add_child_autofree(player)
	gut.simulate(player, 20, .1)
	assert_eq(player.position, Vector2.ZERO, 'Player position should be Vector2.ZERO if no position is setted')

func test_assert_eq_mov_pos():
	var player = Player.new()
	var anim = AnimationPlayer.new()
	anim.name = "AnimationPlayer"
	player.add_child(anim)
	
	var sprite2D = Sprite2D.new()
	sprite2D.name = "Sprite2D"
	player.add_child(sprite2D)

	add_child_autofree(player)
	player.movePlayerToPos(Vector2(5,0), false)
	gut.simulate(player, 20, .1)
	print(player.position)
	assert_eq(player.position.x > 4.5, true , 'Player position should be Vector2(5,0)')
