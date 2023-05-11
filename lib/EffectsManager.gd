extends Node2D

var explosion_scene : PackedScene = preload("res://entities/particles/simple_hit_particles.tscn")

func _ready():
	GameSignals.connect("effect_requested", create_effect)
	
func create_effect(sfx : PackedScene, pos : Vector2):
	var explode = sfx.instantiate()
	explode.position = pos
	
	add_child(explode)
	explode.set_as_top_level(true)
	
	if("emitting" in explode):
		explode.emitting = true
