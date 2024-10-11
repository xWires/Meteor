extends Node

@onready var onMobile:bool = OS.has_feature("web_android") or OS.has_feature("web_ios") or OS.has_feature("android") or OS.has_feature("ios")
var pauseMenu:Node
var gameOverMenu:Node
