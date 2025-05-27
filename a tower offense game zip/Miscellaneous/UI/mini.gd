extends Button
class_name BotButton


signal bot_spawn(bot_name: String)
@export var bot_name: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(emit_bot_spawn)

func emit_bot_spawn():
	bot_spawn.emit(bot_name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
