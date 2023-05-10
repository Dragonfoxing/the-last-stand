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
		
	var collided = move_and_slide()
	
	if(collided):
		var count = get_slide_collision_count()
		
		for i in count:
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			# do something with this profane knowledge
	pass

func on_collided(obj : GameEntity2D):
	queue_free()
