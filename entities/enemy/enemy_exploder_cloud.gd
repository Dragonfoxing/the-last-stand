extends GameEntity2D

@export var explosion_sound = preload("res://assets/sounds/JSFXR_ExploderExplosion.wav")
var initial_velocity : Vector2

func _ready():
	team = "neutral"
	tag = "explosion"
	$AudioStreamPlayer2D.stream = explosion_sound
	$AudioStreamPlayer2D.play()
	
func _physics_process(delta):
	print(velocity)
	move_and_collide(velocity * delta * 0.5)

func _on_timer_timeout():
	set_physics_process(false)
	queue_free()
