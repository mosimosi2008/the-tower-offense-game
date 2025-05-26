extends Bot



var stun_time: float = 1
var areas
func on_death():
	self.set_process(false)
	shockwave()
	await get_tree().create_timer(0.2).timeout
	super.on_death()

func shockwave():
	$Sprite2D.visible = false
	$Hitbox.visible = true
	areas = $Hitbox.get_overlapping_areas()
	for area in areas:
		if area.get_parent() is Tower:
			#Maybe check for walls?

			find_parent("Main").stun(stun_time, area.get_parent())
