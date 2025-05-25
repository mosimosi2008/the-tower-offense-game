extends Node2D

class_name Projectile

var damage: int
var airspeed: float 
var CanPassWalls: bool
var direction 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	direction = direction.normalised()
	position += direction * airspeed
	
