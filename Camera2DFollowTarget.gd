extends Camera2D
# This script assumes you've tuned the Smoothing / Limit / etc settings to your tastes.

@export var target : Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(target.position != position): position = target.position
