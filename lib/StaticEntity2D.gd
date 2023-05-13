extends StaticBody2D
class_name StaticEntity2D

signal Collided(obj : PhysicsBody2D)

# tag metadata, useful for debugging.
@export var tag : String

# is it an enemy or a player object, or neutral?
@export var team : String
