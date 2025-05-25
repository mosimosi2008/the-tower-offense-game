extends Node2D

var current_path: Path2D
var cogs: int
const starting_cogs: int = 200
var bot: Bot


var bot_dict: Dictionary = {
	"test": preload("uid://cdv3bxyerik2f"),
	"boom": preload("uid://v4pgqv47la"),
	"heal": preload("uid://c767vqha1r5x8")
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cogs = starting_cogs
	current_path = $Path2D

#TEST, REMEMBER TO REMOVE THIS
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		spawn_bot("heal")
		await get_tree().create_timer(0.5).timeout
		spawn_bot("test")
		bot.take_damage(5)
	if event.is_action_pressed("ui_down"):
		bot.take_damage(20)
	if event.is_action_pressed("ui_right"):
		print("projectile fired")
		test_projectile()
	if event.is_action_pressed("ui_left"):
		$TestTower.attack()
#REMOVE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func test_projectile():
	var proj = preload("res://test_projectile.tscn").instantiate()
	proj.position = Vector2(10, 300)
	proj.direction = Vector2(1, 0)
	add_child(proj)

func spawn_bot(bot_name):
	bot = bot_dict[bot_name].instantiate()
	if cogs >= bot.cog_cost:
		current_path.add_child(bot)
		bot.bot_finish.connect(bot_finish)
		cogs-= bot.cog_cost
	print("cogs: ")
	print(cogs)
	print()

func bot_finish(cog_return):
	cogs += cog_return
	print("Bot finish in main")
	print("cogs:")
	print(cogs)
	print()
