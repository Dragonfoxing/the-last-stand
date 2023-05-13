extends StaticEntity2D

@export var explosion_sound = preload("res://assets/sounds/JSFXR_ExploderExplosion.wav")

func _ready():
	team = "neutral"
	tag = "explosion"
	
	$AudioStreamPlayer2D.stream = explosion_sound
	$AudioStreamPlayer2D.play()

func _on_timer_timeout():
	queue_free()
