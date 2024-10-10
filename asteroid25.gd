extends Area2D

var speed = 50
var random = RandomNumberGenerator.new()
var screen_size
var randomX
var randomY
var spawnLocation:Vector2
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
		var score = get_node("/root/Game/UserInterface/ScoreLabel")
		get_node("/root/Game").gameInProgress = false
		get_node("/root/Game").spawnAllowed = false
		get_node("/root/Game/Player").queue_free.call_deferred()
		get_node("/root/Game/GameOverMenuContainer").show()
		get_node("/root/Game/GameOverMenuContainer/GameOverMenu/Restart").grab_focus()
		get_node("/root/Game").saveHighScore(score.score)
		get_node("/root/Game/GameOverMenuContainer/GameOverMenu/HighScoreText/HighScore").text = "[center]" + str(get_node("/root/Game").getHighScore()) + "[/center]" 

func _on_area_entered(area):
	var score = get_node("/root/Game/UserInterface/ScoreLabel")
	score.score += 1
	area.get_parent().queue_free()
	get_parent().queue_free()

func setSpawnLocation(location):
	spawnLocation = location

func updateScreenSize():
	screen_size = $"/root/Game".get_viewport_rect().size
