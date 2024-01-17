extends Area2D

@export var speed = 1000
var timer := Timer.new()

func _ready():
	add_child(timer)
	timer.wait_time = 2
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", _on_timer_timeout)

func _on_timer_timeout():
	queue_free()

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("asteroid"):
		body.queue_free()
	queue_free()
