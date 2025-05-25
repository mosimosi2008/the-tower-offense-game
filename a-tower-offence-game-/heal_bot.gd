extends Bot

var bot_hitboxes: Array[Area2D]
var timer = 0
func behaviour(delta):
	timer += delta
	if timer >= 1:
		bot_hitboxes = $HealBox.get_overlapping_areas()
		for bot in bot_hitboxes:
			if bot!= $Hurtbox:
				bot.get_parent().heal(1)
		timer = 0
		
