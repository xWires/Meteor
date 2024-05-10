extends Area2D

var speed = 50
var random = RandomNumberGenerator.new()
var screen_size
var randomX
var randomY
var spawnLocation:Vector2
@export var smallAsteroid:PackedScene
var gFlagNoDamage

# Called when the node enters the scene tree for the first time.
func _ready():
	gFlagNoDamage = get_node("/root/Game").flagExists("nodamage")
	screen_size = get_parent().get_parent().get_viewport_rect().size
	random.randomize()
	randomX = randf_range(-1, 1)
	randomY = randf_range(-1, 1)
	if spawnLocation == Vector2.ZERO:
		spawnLocation.x = randf_range(0, screen_size.x)
		spawnLocation.y = randf_range(0, screen_size.y)
	self.position = spawnLocation
	self.rotation = randi_range(-180, 180)

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	pass

func _physics_process(delta):
	position += Vector2(randomX, randomY) * speed * delta
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	if !gFlagNoDamage:
		var score = get_node("../../UserInterface/ScoreLabel")
		get_node("../..").gameInProgress = false
		get_node("../..").spawnAllowed = false
		get_node("../../Player").queue_free.call_deferred()
		get_node("../../GameOverMenu").show()
		get_node("../../GameOverMenu/Restart").grab_focus()
		get_node("../..").saveHighScore(score.score)
		get_node("../../GameOverMenu/HighScoreText/HighScore").text = "[center]" + str(get_node("../..").getHighScore()) + "[/center]" 

func _on_area_entered(area):
	var score = get_node("../../UserInterface/ScoreLabel")
	score.score += 1
	var spawner = get_node("../..")
	for i in 2:
		var a = smallAsteroid.instantiate()
		a.get_node("Asteroid").spawnLocation.x = self.position.x
		a.get_node("Asteroid").spawnLocation.y = self.position.y
		get_node("../..").add_child.call_deferred(a)
	queue_free()
	area.queue_free()

func setSpawnLocation(location):
	spawnLocation = location
