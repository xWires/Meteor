extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ok"):
		if get_viewport().gui_get_focus_owner() == $Continue:
			_on_continue_pressed()
		elif get_viewport().gui_get_focus_owner() == $Quit:
			_on_quit_pressed()

func _on_continue_pressed():
	hide()
	get_tree().paused = false

func _on_quit_pressed():
	get_tree().quit()
