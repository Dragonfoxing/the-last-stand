extends CharacterBody2D

@export var width : int = 8
@export var height : int = 8

@export var speed : int = 80

@export var limit : Vector2 = Vector2(800, 600)

@export var sprite : Sprite2D

@export var bullet_prefab : PackedScene

var right : bool = false;

func _ready():
	set_meta("tag", "player")
	
func _input(event):
	if(event.is_action_pressed("left_click") or event.is_action_pressed("ui_accept")):
		spawn_bullet()
	pass
	
func spawn_bullet():
	var bill : CharacterBody2D = bullet_prefab.instantiate()
	bill.position = position
	bill.set_meta("tag", "player")
	owner.add_child(bill)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var dir = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down"))

	velocity = (dir.normalized() * delta * 100 * speed)
	
	if move_and_slide(): _check_collisions()
	
	_check_flip_animation()
	_check_if_moving_to_limit()

func _check_collisions():
	var count = get_slide_collision_count()
	
	for i in count:
		var col = get_slide_collision(i)
		var collider = col.get_collider()
		
		if(is_instance_valid(collider) && collider.has_meta("tag") && collider.get_meta("tag") == "enemy"):
			queue_free()
	
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
