extends CharacterBody2D
class_name GameEntity2D

signal Collided(obj : PhysicsBody2D)

# tag metadata, useful for debugging.
@export var tag : String

# is it an enemy or a player object, or neutral?
@export var team : String

func pause():
	set_physics_process(false)
	
func unpause():
	set_physics_process(true)
