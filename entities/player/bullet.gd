extends GameEntity2D

const speed : int = 80

const tick_expiration_max : int = 60
var tick_expiration_cur : int = 0

func _ready():
	tag = "bullet"
	connect("Collided", on_collided)
	
func _physics_process(delta):
	tick_expiration_cur += 1
	if(tick_expiration_cur >= tick_expiration_max):
		queue_free()
		
	move_and_slide()

func on_collided(obj : Area2D):
	# do collision logic here instead of in physics process
	queue_free()
