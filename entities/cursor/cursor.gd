extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass # Replace with function body.

func _process(delta):
	position = get_global_mouse_position()

func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
