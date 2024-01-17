extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Correct signal for handling input
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		# Get global rect bounds
		var rect_min = get_rect().position
		var rect_max = rect_min + get_rect().size

		# Check if the mouse click occurred within the TextureRect bounds
		if event.global_position.x >= rect_min.x and event.global_position.x <= rect_max.x and event.global_position.y >= rect_min.y and event.global_position.y <= rect_max.y:
			print("Mouse button pressed inside TextureRect")
			get_tree().change_scene("res://game.tscn")
