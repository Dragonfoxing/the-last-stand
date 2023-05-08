extends Node2D

@export var play_scene : PackedScene

func _input(event):
	if(event.is_action_pressed("left_click")):
		get_tree().change_scene_to_packed(play_scene)
