extends Area2D

@export var speed = 1000
var timer := Timer.new()
var screen_size

func _ready():
	screen_size = get_parent().get_parent().get_viewport_rect().size
	add_child(timer)
	timer.wait_time = 2
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", _on_timer_timeout)

func _on_timer_timeout():
	get_node("..").queue_free()

func _physics_process(delta):
	position += transform.x * speed * delta
	if get_node("/root/Game").flagExists("wrapbullets"):
		position.x = wrapf(position.x, 0, screen_size.x)
		position.y = wrapf(position.y, 0, screen_size.y)

#func _on_Bullet_body_entered(body):
	#if body.is_in_group("asteroid"):
		#body.queue_free()
	#get_node("..").queue_free()

func updateScreenSize():
	screen_size = $"/root/Game".get_viewport_rect().size
