extends Node2D

var explosion_scene : PackedScene = preload("res://entities/particles/simple_hit_particles.tscn")

func _ready():
	GameSignals.connect("effect_requested", create_effect)
	
func create_effect(sfx : PackedScene, pos : Vector2, values : Dictionary = {}):
	var effect = sfx.instantiate()
	effect.position = pos
	
	call_deferred("add_child", effect)
	effect.set_as_top_level(true)
	
	print(values)

	for value in values:
		if value in effect:
			effect[value] = values[value]
			print(effect[value])
