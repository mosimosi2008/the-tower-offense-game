extends Node2D

class_name Projectile

@export var damage: int
@export var airspeed: float 
@export var can_pass_walls: bool
@export var max_pierce: int
@export var max_lifetime: float

var lifetime: float = 0
var pierce: int
var direction: Vector2
var hit_log: Array = []
var bot
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pierce = max_pierce
	find_child("Hitbox").area_entered.connect(on_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * airspeed
	lifetime += delta
	if lifetime >= max_lifetime:
		destroy()

func on_hit(area):
	bot = area.get_parent()
	if bot not in hit_log:
		hit_log.append(bot)
		pierce-=1
		if pierce <= 0:
			destroy()

func destroy():
	self.queue_free()
