extends Node2D

@export var Asteroid:PackedScene

var shouldSpawn = true
var screen_size
var config = ConfigFile.new()
var err = config.load("user://options.cfg")

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	if config.get_value("options", "volume") != null:
		$PauseMenu/VolumeSlider.value = config.get_value("options", "volume")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shouldSpawn:
		spawnAsteroid(1)
		$AsteroidSpawnCooldown.start()
		shouldSpawn = false
	setVolumeOption($PauseMenu/VolumeSlider.value)
	saveConfig()

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
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		$PauseMenu.show()
		$PauseMenu/Continue.grab_focus()

func saveConfig():
	config.save("user://options.cfg")
	
func setVolumeOption(volume:float):
	config.set_value("options", "volume", volume)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		onExit()
		get_tree().quit()

func onExit():
	setVolumeOption($PauseMenu/VolumeSlider.value)
	saveConfig()
