extends Node2D

@export var width : int = 8
@export var height : int = 8

@export var limit : Vector2 = Vector2(800, 600)

@export var sprite : Sprite2D

var right : bool = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var dir = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down"))

	var moveDelta = (dir * delta * 100)
	position += moveDelta
	
	_check_flip_animation(moveDelta)
	_check_if_moving_to_limit()

func _check_flip_animation(moveDelta):
	if(!right && moveDelta.x > 0):
		right = true
		sprite.flip_h = right
	elif(right && moveDelta.x < 0):
		right = false
		sprite.flip_h = right
	
func _check_if_moving_to_limit():
	if(position.x < width): position.x = width;
	elif(position.x > limit.x - width): position.x = limit.x - width;
	
	if(position.y < height): position.y = height;
	elif(position.y > limit.y - height): position.y = limit.y - height;
