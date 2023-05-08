extends CharacterBody2D

@export var target : Node2D
@export var speed : int = 40
# Called when the node enters the scene tree for the first time.
func _ready():
	set_meta("tag", "enemy")

func _physics_process(delta):
	if(is_instance_valid(target)):
		var dir = target.position - position
		
		# dir.normalized() would make this speed constant
		# let's try it without! :D
		velocity = dir * delta * speed
		
		var collided = move_and_slide()
		
		if(collided):
			var count = get_slide_collision_count()
			
			for i in count:
				var col = get_slide_collision(i)
				
				# Using set_meta to set tags, we can avoid getting full groups of objects
				# and just check the object metadata for the tag we're looking for.
				
				var collider = col.get_collider()
				
				if(is_instance_valid(collider) and collider.get_meta("tag") == "player"):
					queue_free()
	else:
		# if the player is dead, we stop processing physics.
		# in more complicated cases, we want alternate behavior rather than this.
		set_physics_process(false)
