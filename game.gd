extends Node2D

@export var Asteroid:PackedScene

var spawnAllowed = true
var shouldSpawn = true
var screen_size
var config = ConfigFile.new()
var err = config.load("user://options.cfg")
var gameInProgress = true
var highScore

@export var pAccel = 5
@export var pDecel = 0.5
@export var pMaxSpeed = 200
@export var pRotSpeed = 3
@export var pFireCooldown = 0.5

var gFlags:Array

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
	if OS.get_environment("METEOR_P_ACCELERATION") != null and OS.get_environment("METEOR_P_ACCELERATION").to_float() != 0:
	#if OS.get_environment("METEOR_P_ACCELERATION") != null:
		pAccel = OS.get_environment("METEOR_P_ACCELERATION").to_float()
		print("Player acceleration: " + str(pAccel))
	if OS.get_environment("METEOR_P_DECELERATION") != null and OS.get_environment("METEOR_P_DECELERATION").to_float() != 0:
	#if OS.get_environment("METEOR_P_DECELERATION") != null:
		pDecel = OS.get_environment("METEOR_P_DECELERATION").to_float()
		print("Player deceleration: " + str(pDecel))
	if OS.get_environment("METEOR_P_MAXSPEED") != null and OS.get_environment("METEOR_P_MAXSPEED").to_float() != 0:
	#if OS.get_environment("METEOR_P_MAXSPEED") != null:
		pMaxSpeed = OS.get_environment("METEOR_P_MAXSPEED").to_float()
		print("Player max speed: " + str(pMaxSpeed))
	if OS.get_environment("METEOR_P_ROTSPEED") != null and OS.get_environment("METEOR_P_ROTSPEED").to_float() != 0:
	#if OS.get_environment("METEOR_P_ROTSPEED") != null:
		pRotSpeed = OS.get_environment("METEOR_P_ROTSPEED").to_float()
		print("Player rotation speed: " + str(pRotSpeed))
	if OS.get_environment("METEOR_P_FIRECOOLDOWN") != null and OS.get_environment("METEOR_P_FIRECOOLDOWN").to_float() != 0:
	#if OS.get_environment("METEOR_P_FIRECOOLDOWN") != null:
		pFireCooldown = OS.get_environment("METEOR_P_FIRECOOLDOWN").to_float()
		print("Player fire cooldown: " + str(pFireCooldown))
	if OS.get_environment("METEOR_G_FLAGS") != null and OS.get_environment("METEOR_G_FLAGS") != "":
		gFlags = OS.get_environment("METEOR_G_FLAGS").replace(" ", "").split(",")
		print("Game Flags: " + str(gFlags))
		
	if config.get_value("options", "volume") != null:
		$PauseMenu/VolumeSlider.value = config.get_value("options", "volume")
	if config.get_value("options", "hue") != null:
		$PauseMenu/HueSlider.value = config.get_value("options", "hue")

	print("Running on " + OS.get_name())

	if OS.get_name() == "Web":
		$PauseMenu/Quit.hide()
		$GameOverMenu/Quit.hide()

	$Player.acceleration = pAccel
	$Player.deceleration = pDecel
	$Player.maximumSpeed = pMaxSpeed
	$Player.rotationSpeed = pRotSpeed
	$Player/WeaponCooldown.wait_time = pFireCooldown

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shouldSpawn and spawnAllowed and !flagExists("nometeors"):
		spawnAsteroid(1)
		$AsteroidSpawnCooldown.start()
		shouldSpawn = false
	setVolumeOption($PauseMenu/VolumeSlider.value)
	saveConfig()

func spawnAsteroid(size, location=null):
	var a = Asteroid.instantiate()
	add_child.call_deferred(a)
	#print_debug(size)
	if size is Vector2:
		a.scale = size
	else:
		a.scale = Vector2(float(size), float(size))
	if location != null:
		a.get_node("Asteroid").setSpawnLocation(location)
	#print_debug(Time.get_datetime_string_from_system(), " ",  "Spawned asteroid")

func _on_asteroid_spawn_cooldown_timeout():
	shouldSpawn = true
		
func _input(event):
	if Input.is_action_just_pressed("pause") and gameInProgress:
		get_tree().paused = true
		$PauseMenu.show()
		$PauseMenu/Continue.grab_focus()

func saveConfig():
	config.save("user://options.cfg")
	
func setVolumeOption(volume:float):
	config.set_value("options", "volume", volume)

func saveHighScore(score):
	if !flagExists("nosavescore") and config.get_value("scores", "high_score", 0) < score:
		config.set_value("scores", "high_score", score)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		onExit()
		get_tree().quit()

func onExit():
	saveHighScore($UserInterface/ScoreLabel.score)
	setVolumeOption($PauseMenu/VolumeSlider.value)
	setHueOption($PauseMenu/HueSlider.value)
	saveConfig()

func getHighScore():
	return config.get_value("scores", "high_score", 0)

func _on_colour_slider_value_changed(value):
	material.set_shader_parameter("Shift_Hue", value)
	setHueOption(value)

func setHueOption(hue:float):
	config.set_value("options", "hue", hue)

func flagExists(flag:String):
	if gFlags != null:
		return gFlags.has(flag)
	else:
		return false
