#To make a new tower type make a new scene with the root node being of the tower class
#Drag the projectile scene file for the desired projectile file from the bottom left explorer into the projecting variable export
#add a raycast2d node as well as an area 2d Node and assign these to their export variables as well as denoting a cooldown



extends Node2D
class_name Tower

@export var detection_area : Area2D
@export var ray_cast: RayCast2D
@export var projectile: PackedScene
@export var max_cooldown: float


var cooldown_timer: float
var attack_speed: float 
var areas: Array[Area2D]
var bot: Bot
var target: Bot
var dir

	

func _ready() -> void:
	cooldown_timer = max_cooldown#



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	cooldown_timer-= delta
	
	if cooldown_timer <= 0:
		cooldown_timer = 0
		attack()
			

func attack():
	#Find all areas in detection
	areas = detection_area.get_overlapping_areas()
	for area in areas:
		bot = area.get_parent()
		#Target RayCast at bot
		ray_cast.target_position = bot.global_position-ray_cast.global_position
		if !ray_cast.is_colliding():
			if !target:
				target = bot
			elif target.is_in_group("Pop_Bot") and !bot.is_in_group("Pop_Bot"):
				target = bot
			elif bot.progress > target.progress:
				#PopBot logic
				if !bot.is_in_group("Pop_Bot") or (target.is_in_group("Pop_Bot") and bot.is_in_group("Pop_Bot")):
					target = bot
		
	#After found target:
	if target:
		dir = target.global_position-self.global_position
		var proj = projectile.instantiate()
		proj.direction = dir
		add_child(proj)
		target = null
		bot = null
		cooldown_timer = max_cooldown

	else:
		cooldown_timer = 0.1

func stun(time):
	self.set_process(false)
	await get_tree().create_timer(time).timeout
	self.set_process(true)
	
