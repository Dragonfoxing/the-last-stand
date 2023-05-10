extends Node2D

@export var player : Node2D
@export var camera : Camera2D

var width : int = 800
var height : int = 600

@export var enemies : Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready():
	_reset_entities()

func _reset_entities():
	player.position = Vector2(width/2, height/2)
	camera.position = player.position
	
func _spawn_entity():
	pass
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"): _send_quit_request()
	elif event.is_action_pressed("reload_scene"): get_tree().reload_current_scene()
	
# This lets the game handle any custom quit functionality.
# In theory every notification handler will be called before we quit(0)
func _send_quit_request():
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit(0)
