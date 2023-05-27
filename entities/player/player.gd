extends GameEntity2D

@export var width : int = 8
@export var height : int = 8

@export var speed : int = 80

@export var limit : Vector2 = Vector2(800, 600)

@export var sprite : Sprite2D

@export var god_mode : bool = false

@export var player_death_effect : PackedScene
var right : bool = false;

@onready var the_gun = get_node("%Gun")

func _ready():
	team = "player"
	connect("Collided", _on_collided)
	GameSignals.connect("player_killed_enemy", _on_killed_enemy)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var dir = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down"))

	velocity = (dir.normalized() * (speed * (1 + GameDifficulty.scale/8)))
	
	#if move_and_slide(): _check_collisions()
	
	move_and_slide()
	
	_check_flip_animation()
	_check_if_moving_to_limit()
	
func _check_flip_animation():
	if(!right && velocity.x > 0):
		right = true
		sprite.flip_h = right
	elif(right && velocity.x < 0):
		right = false
		sprite.flip_h = right
	
func _check_if_moving_to_limit():
	if(position.x < width): position.x = width;
	elif(position.x > limit.x - width): position.x = limit.x - width;
	
	if(position.y < height): position.y = height;
	elif(position.y > limit.y - height): position.y = limit.y - height;

func _on_collided(obj : Area2D):
	if(not god_mode):
		var col = obj.owner as GameEntity2D
		if(col.team == "enemy" or col.tag == "explosion"): _on_death()

func _on_death():
	GameSignals.emit_signal("effect_requested", player_death_effect, position)
	$AudioStreamPlayer2D.play()
	set_physics_process(false)
	#$Gun.queue_free()
	$Sprites/Sprite2D.queue_free()
	await $AudioStreamPlayer2D.finished
	queue_free()
	
func _on_killed_enemy():
	the_gun.add_ammo(1)
