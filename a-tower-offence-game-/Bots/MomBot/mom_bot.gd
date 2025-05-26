extends Bot

signal mom_bot_death
var child = preload("uid://b1ce7dj2gvc4g")
var children: Array[Bot] = []
func on_death():
	for i in range(4):
		children.append(child.instantiate())
		children[i].progress = self.progress + randf_range(0,100)
		get_parent().add_child(children[i])
	mom_bot_death.emit(children)
	super.on_death()
