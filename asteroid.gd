extends Area2D

var speed = 50
var random = RandomNumberGenerator.new()
var screen_size
var randomX
var randomY
var movement = Vector2.ZERO
var spawnLocation = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_parent().get_parent().get_viewport_rect().size
	random.randomize()
	randomX = randf()
	randomY = randf()
	print_debug(get_parent())
	print_debug(get_parent().get_parent())
	print_debug(get_parent().get_parent().get_viewport_rect())
	spawnLocation.x = randf_range(0, screen_size.x)
	spawnLocation.y = randf_range(0, screen_size.y)
	self.position = spawnLocation
	self.rotation = randi_range(0, 360)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	position += Vector2(randomX, randomY) * speed * delta
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
	print_debug(position)

func _on_body_entered(body):
	get_tree().reload_current_scene()

func _on_area_entered(area):
	queue_free()
	area.queue_free()
