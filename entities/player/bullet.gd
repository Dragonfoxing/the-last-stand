extends CharacterBody2D

const speed : int = 80

func _ready():
	pass
	
func _physics_process(delta):
	velocity = Vector2.LEFT * delta * speed * 100
	
	var collided = move_and_slide()
	
	if(collided):
		var count = get_slide_collision_count()
		
		for i in count:
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			
			# do something with this profane knowledge
	pass
