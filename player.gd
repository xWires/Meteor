extends CharacterBody2D

@export var acceleration = 5
@export var deceleration = 0.5
@export var maximumSpeed = 200
@export var rotationSpeed = 3

var canFire = true

@export var Bullet:PackedScene

var rotationDirection = 0
var velocityDirection = 0
var screen_size
var children

@onready var pauseMenu:Node

var rotatingLeft:bool = false
var rotatingRight:bool = false
var thrusting:bool = false
var firing:bool = false

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	if Input.is_action_pressed("fire") or firing:
		fireWeapon()

func fireWeapon():
	pauseMenu = Globals.pauseMenu
	if canFire:
		if pauseMenu.get_node("VolumeSlider").value != 0:
			$Weapon/ShootSoundEffect.volume_db = pauseMenu.get_node("VolumeSlider").value
			$Weapon/ShootSoundEffect.play()
		var b = Bullet.instantiate()
		$"/root/Game/BulletContainer".add_child(b)
		b.get_child(0).transform = $Weapon.global_transform
		$WeaponCooldown.start()
		canFire = false

func get_input():
	rotationDirection = Input.get_axis("left", "right")
	velocityDirection = Input.get_axis("down", "up")
	#velocity += transform.x * Input.get_axis("down", "up") * acceleration
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
	if rotatingLeft:
		rotationDirection = -1
	if rotatingRight:
		rotationDirection = 1
	if thrusting:
		velocityDirection = 1
	rotation += rotationDirection * rotationSpeed * delta
	velocity += transform.x * velocityDirection * acceleration
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

func _on_timer_timeout():
	canFire = true

func updateScreenSize():
	screen_size = $"/root/Game".get_viewport_rect().size

func _on_rotate_left_pressed() -> void:
	rotatingLeft = true

func _on_rotate_left_released() -> void:
	rotatingLeft = false

func _on_rotate_right_pressed() -> void:
	rotatingRight = true

func _on_rotate_right_released() -> void:
	rotatingRight = false

func _on_thrust_pressed() -> void:
	thrusting = true

func _on_thrust_released() -> void:
	thrusting = false

func _on_fire_pressed() -> void:
	firing = true

func _on_fire_released() -> void:
	firing = false
