extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ok"):
		if get_viewport().gui_get_focus_owner() == $Restart:
			_on_restart_pressed()
		elif get_viewport().gui_get_focus_owner() == $Quit:
			_on_quit_pressed()

func _on_restart_pressed():
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_node("..").onExit()
	get_tree().quit()
