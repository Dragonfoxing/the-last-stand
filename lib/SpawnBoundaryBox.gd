extends Marker2D
class_name SpawnBoundaryBox

@export var size : Vector2 = Vector2(800, 600)

@export var spawnDistance : float = 300
@export var boundsDistance : float = 1200
@export var target : Node2D

class _bound extends RefCounted:
	var start : float
	var end : float
	
var _xBound : _bound = _bound.new()
var _yBound : _bound = _bound.new()

var xBound:
	get:	
		_xBound.start = target.position.y - size.x/2
		_xBound.end = target.position.y + size.x/2
		
		return _xBound
		
var yBound:
	get:
		_yBound.start = target.position.y - size.y/2
		_yBound.end = target.position.y + size.y/2
		
		return _yBound

func _process(delta):
	queue_redraw()
	
func is_in_bounds (x, y) -> bool: 
	var _x = xBound
	var _y = yBound
	
	return (x <= _x.end
	and x >= _x.start
	and y <= _y.end
	and y >= _y.start)

func _draw():
	
	draw_circle(target.position, spawnDistance, Color.DARK_GOLDENROD)
	draw_circle(target.position, 200, Color.DARK_ORANGE)
	draw_circle(target.position, 100, Color.DARK_RED)
	#draw_circle(target.position, boundsDistance, Color.DARK_GRAY)
