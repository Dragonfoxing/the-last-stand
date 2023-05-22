extends GameEntity2D

@export var target : Node2D
@export var speed : float = 40

@export var death_particles : PackedScene

var dead : bool = false
var dir : Vector2

func _ready():
	team = "enemy"
	
	connect("Collided", _on_collided)
	
func _physics_process(delta):
	if(is_instance_valid(target) and not dead):
		dir = target.position - position
		
		# dir.normalized() would make this speed constant
		# let's try it without! :D
		velocity = dir * delta * speed
		
		move_and_slide()
	
# all of our logic is in physics_process so we don't need code here.
func _on_collided(obj : Area2D):
	var col = obj.owner as GameEntity2D
	
	if col.team != "enemy":
		_on_death(col)

func _on_death(col : GameEntity2D):
	# Stop processing move_and_slide
	set_physics_process(false)
	
	# Make sure our hitbox isn't used to register collisions
	$Hitbox.set_collision_layer(0)
	$Hitbox.set_collision_mask(0)
	
	# disable collisions by setting the bitmask for layer and mask to 0
	set_collision_layer(0)
	set_collision_mask(0)
	
	# Assign points only if it's right to do so
	if col.tag == "bullet" or col.tag == "explosion":
		GameDifficulty.add_score(1)
		GameSignals.emit_signal("player_killed_enemy")
	
	# set up the options for spawning effects
	# we include the velocity for effects that might need that
	var options = {
		"emitting": true,
		"velocity": dir.normalized() * speed
	}
	
	# send out the request for death effect spawn
	GameSignals.emit_signal("effect_requested", death_particles, position, options)
	
	# Disable the visuals for this enemy and clear the enemy when audio is done playing
	$Sprite2D.queue_free()
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	queue_free()
