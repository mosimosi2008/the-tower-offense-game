extends Projectile

func destroy():
	areas = HitBox.get_overlapping_areas()
	for area in areas:
		
