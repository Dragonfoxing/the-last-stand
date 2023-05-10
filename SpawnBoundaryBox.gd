extends Marker2D
class_name SpawnBoundaryBox

@export var size : Vector2 = Vector2(800, 600)

class _bound extends RefCounted:
	var start : float
	var end : float
	
var _xBound : _bound = _bound.new()
var _yBound : _bound = _bound.new()

var xBound:
	get:	
		_xBound.start = position.y - size.x/2
		_xBound.end = position.y + size.x/2
		
		return _xBound
		
var yBound:
	get:
		_yBound.start = position.y - size.y/2
		_yBound.end = position.y + size.y/2
		
		return _yBound

func is_in_bounds (x, y) -> bool: 
	var _x = xBound
	var _y = yBound
	
	return (x <= _x.end
	and x >= _x.start
	and y <= _y.end
	and y >= _y.start)
