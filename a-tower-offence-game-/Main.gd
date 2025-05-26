extends Node2D

var current_path: Path2D
var cogs: int
const starting_cogs: int = 100000
var bot: Bot


var bot_dict: Dictionary = {
	"test": preload("uid://cdv3bxyerik2f"),
	"boom": preload("uid://v4pgqv47la"),
	"heal": preload("uid://c767vqha1r5x8"),
	"mom": preload("uid://emtn7fi6irv6"),
	"pop": preload("uid://bovma4wp2rk2r")
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cogs = starting_cogs
	current_path = $Path2D

#TEST, REMEMBER TO REMOVE THIS
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		spawn_bot("mom")
	
	if event.is_action_pressed("ui_up"):
		spawn_bot("pop")
		
	if event.is_action_pressed("ui_down"):
		bot.take_damage(20)

		
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
		if bot_name == "mom":
			bot.mom_bot_death.connect(mom_bot_death)
	print("cogs: ")
	print(cogs)
	print()

func bot_finish(cog_return):
	cogs += cog_return
	print("Bot finish in main")
	print("cogs:")
	print(cogs)
	print()

func stun(stun_time: float, tower: Tower):
	tower.stun(stun_time)

func mom_bot_death(children):
	for child in children:
		child.bot_finish.connect(bot_finish)
