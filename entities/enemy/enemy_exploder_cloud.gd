extends StaticEntity2D

func _ready():
	team = "neutral"
	tag = "explosion"

func _on_timer_timeout():
	queue_free()
