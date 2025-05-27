#To make a new projectile type, make a new scene with the base node being a projectile
#Add an area named "Hitbox"(This is important) and all that Jazz
#To add extra logic to a projectile, attach a script that extends "Projectile" - DO NOT alter this script for behaviour specific to one projectile
#If the projectile should have unique behaviour during flight, program this under a function you name "behaviour"
#If the projectile should have unique behaviour on hit, program this under a function you name "on_hit_behaviour"
#If the projectile should have unique behaviour when it is destroyed, program this under a function you name "destroy" and follow this code(but still within the function) with "self.queue_free()"


extends Node2D

class_name Projectile

@export var damage: int
@export var airspeed: float 
@export var can_pass_walls: bool
@export var max_pierce: int
@export var max_lifetime: float
@export var HitBox: Area2D

var lifetime: float = 0
var pierce: int
var direction: Vector2
var hit_log: Array = []
var bot


func _ready() -> void:
	#Pierce referes to how many bots the attack goes through before expiring
	pierce = max_pierce
	#Connect the hitbox entered to the on_hit 
	find_child("Hitbox").area_entered.connect(on_hit)



func _process(delta: float) -> void:
	global_position += direction * airspeed
	lifetime += delta
	if lifetime >= max_lifetime:
		destroy()
	behaviour()

func on_hit(area):
	#check if bot has already been hit
	bot = area.get_parent()
	if bot not in hit_log:
		hit_log.append(bot)
		#hit bot
		on_hit_behaviour()
		pierce-=1
		if pierce <= 0:
			destroy()

func destroy():
	self.queue_free()


func on_hit_behaviour():
	pass
	
func behaviour():
	pass
