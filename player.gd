extends CharacterBody2D

@export var acceleration = 5
@export var deceleration = 0.5
@export var maximumSpeed = 200
@export var rotation_speed = 1.5

var canFire = true

@export var Bullet:PackedScene

var rotation_direction = 0
var screen_size
var children

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	if Input.is_action_pressed("fire"):
		fireWeapon()

func fireWeapon():
	if canFire:
		var b = Bullet.instantiate()
		owner.add_child(b)
		b.transform = $Weapon.global_transform
		$WeaponCooldown.start()
		canFire = false

func get_input():
	rotation_direction = Input.get_axis("left", "right")
	velocity += transform.x * Input.get_axis("down", "up") * acceleration
	#if velocity < maximumSpeed:
		#velocity += transform.x * Input.get_axis("down", "up") * acceleration

func _physics_process(delta):
	if velocity.x > maximumSpeed:
		velocity.x = maximumSpeed
	if velocity.x < -maximumSpeed:
		velocity.x = -maximumSpeed
	if velocity.y > maximumSpeed:
		velocity.y = maximumSpeed
	if velocity.y < -maximumSpeed:
		velocity.y = -maximumSpeed
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	#move_and_slide()
	if velocity.x > 0:	
		velocity.x -= deceleration
	if velocity.y > 0:
		velocity.y -= deceleration
	if velocity.x < 0:
		velocity.x += deceleration
	if velocity.y < 0:
		velocity.y += deceleration
		
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
	
	move_and_slide()
	#print_debug(velocity)
	#print_debug(transform.x)


func _on_timer_timeout():
	canFire = true
