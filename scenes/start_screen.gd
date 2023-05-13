extends Node2D

@export var gameScene : PackedScene

func _input(event):
	if(event.is_action_pressed("reload_scene")):
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		get_tree().change_scene_to_packed(gameScene)
		pass
	elif(event.is_action_pressed("ui_cancel")):
		get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
		get_tree().quit(0)
