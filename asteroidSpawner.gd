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
		spawnAsteroid()
		$AsteroidSpawnCooldown.start()
		shouldSpawn = false

func spawnAsteroid():
	var a = Asteroid.instantiate()
	add_child(a)
	print_debug(Time.get_datetime_string_from_system(), " ",  "Spawned asteroid")


func _on_asteroid_spawn_cooldown_timeout():
	shouldSpawn = true

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
