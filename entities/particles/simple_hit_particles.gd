extends CPUParticles2D

func _ready():
	emitting = true
	
func _on_timer_timeout():
	queue_free()

func pause():
	$Timer.paused = true
	speed_scale = 0
	
func unpause():
	$Timer.paused = false
	speed_scale = 1
