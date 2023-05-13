extends GameEntity2D

@export var target : Node2D
@export var speed : float = 40

@export var death_particles : PackedScene

var dead : bool = false

func _ready():
	team = "enemy"
	
	connect("Collided", _on_collided)
	
func _physics_process(delta):
	if(is_instance_valid(target)):
		var dir = target.position - position
		
		# dir.normalized() would make this speed constant
		# let's try it without! :D
		velocity = dir * delta * speed
		
		# move ourself and check if we collided with anything
		var collided = move_and_slide()
		
		if(collided):
			# get the number of collisions and start looping through them for relevant tags
			var count = get_slide_collision_count()
			
			if count > 0:
				for i in count:
					var col = get_slide_collision(i)
					
					if(is_instance_valid(col) and is_instance_valid(col.get_collider())):
						var collider = col.get_collider() as GameEntity2D
						if not collider:
							collider = col.get_collider() as StaticEntity2D
							
						# There was a bug with just doing queue_free() - it will still
						# loop through other collision checks b/c it's not quite gone yet.
						# so we use `and not dead` to make sure we don't duplicate score or calls.
						
						if(is_instance_valid(collider) and not dead):
							if(collider.team == "player"):
								dead = true
								
								if(collider.tag == "bullet"):
									GameDifficulty.add_score(1)
									GameSignals.emit_signal("player_killed_enemy")
									
								collider.emit_signal("Collided", self)
								
								
								
								GameSignals.emit_signal("effect_requested", death_particles, position)
								
								$Sprite2D.queue_free()
								$AudioStreamPlayer2D.play()
								await $AudioStreamPlayer2D.finished
								queue_free()
							elif(collider.tag == "explosion"):
								dead = true
								
								GameDifficulty.add_score(1)
								GameSignals.emit_signal("player_killed_enemy")
									
								GameSignals.emit_signal("effect_requested", death_particles, position)
								
								$Sprite2D.queue_free()
								$AudioStreamPlayer2D.play()
								await $AudioStreamPlayer2D.finished
								queue_free()
	else:
		# if the player is dead, we stop processing physics.
		# in more complicated cases, we want alternate behavior rather than this.
		set_physics_process(false)

func spawn_death_particles():
	var particles = death_particles.instantiate()
	add_child(particles)
	particles.set_as_top_level(true)
	particles.position = position
	particles.emitting = true
	
	
# all of our logic is in physics_process so we don't need code here.
func _on_collided(obj : GameEntity2D):
	pass
