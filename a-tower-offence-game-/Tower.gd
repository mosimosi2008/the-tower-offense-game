extends Node2D
class_name Tower

var detectionarea : Area2D
@onready var projectile = load('res://Projectile.gd')
var attackspeed: float 


func spawn(toTroopVector):
	var instance = projectile.instantiate()
	
	
	

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
