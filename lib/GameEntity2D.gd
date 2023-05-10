extends CharacterBody2D
class_name GameEntity2D

signal Collided(obj : GameEntity2D)

# tag metadata, useful for debugging.
var tag : String

# is it an enemy or a player object, or neutral?
var team : String
