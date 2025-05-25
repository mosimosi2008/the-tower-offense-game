extends PathFollow2D
class_name Bot


signal bot_death
signal bot_finish

@export var max_health: int
@export var move_speed: float
@export var cog_cost: int
@export var cog_multiplier: float


var health: int
const BASE_SPEED: float = 1

func _ready() -> void:
	self.loop = false
	health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += BASE_SPEED*move_speed
	if progress_ratio >= 1:
		finish()
	behaviour(delta)

func behaviour(delta):
	pass

func take_damage(damage):
	health-= damage
	if health <= 0:
		health = 0
		on_death()

func finish():
	bot_finish.emit(cog_cost*cog_multiplier)
	self.queue_free()

func on_death() -> void:
	bot_death.emit()
	self.queue_free()

func heal(healing):
	if health != 0:
		health += healing
		print("healing")
		if health >= max_health:
			health = max_health
			print("overhealing")
