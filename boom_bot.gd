extends Bot



func on_death():
	self.set_process(false)
	shockwave()
	await get_tree().create_timer(0.2).timeout
	super.on_death()

func shockwave():
	$Sprite2D.visible = false
	$Hitbox.visible = true
	
