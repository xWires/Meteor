extends Node2D

@export var Asteroid:PackedScene

var shouldSpawn = true
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shouldSpawn:
		spawnAsteroid(1)
		$AsteroidSpawnCooldown.start()
		shouldSpawn = false

func spawnAsteroid(size, location=null):
	var a = Asteroid.instantiate()
	add_child.call_deferred(a)
	print_debug(size)
	if size is Vector2:
		a.scale = size
	else:
		a.scale = Vector2(float(size), float(size))
	if location != null:
		a.get_node("Asteroid").setSpawnLocation(location)
	print_debug(Time.get_datetime_string_from_system(), " ",  "Spawned asteroid")


func _on_asteroid_spawn_cooldown_timeout():
	shouldSpawn = true

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _on_child_exiting_tree(node):
	print_debug(node)
	if node.name == "AsteroidScene":
		spawnAsteroid(node.scale)
		print_debug("split asteroid")
		
