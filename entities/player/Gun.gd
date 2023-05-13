extends Node2D

@export var bullet_prefab : PackedScene

@export var ammo_max : int = 6
var ammo_cur : int = ammo_max

var tick_delay : int = 30
var tick_cur : int = 0

var shooting : bool = false

@export var canReload : bool = true
var reloading : bool = false
var reload_time_max : float = 1.5
var reload_time_cur : float = 0

@onready var ammo_label = $Label

func _physics_process(delta):
	if(reloading):
		reload_time_cur += delta
		
		if(reload_time_cur >= reload_time_max):
			reloading = false
			ammo_cur = ammo_max
			
			_update_label()
	elif(shooting):
		tick_cur+=1
		if(tick_cur >= tick_delay):
			spawn_bullet()
			tick_cur = 0
	
func _input(event):
	if(event.is_action_pressed("left_click") or event.is_action_pressed("ui_accept")):
		spawn_bullet()
		shooting = true
	elif(event.is_action_released("left_click") or event.is_action_released("ui_accept")):
		tick_cur = 0
		shooting = false
	
func spawn_bullet():
	if(ammo_cur == 0):
		return
	else:
		# start by setting the direction.
		var dir : Vector2 = (get_global_mouse_position() - owner.position).normalized()
		
		var bill : GameEntity2D = bullet_prefab.instantiate()
		
		bill.velocity = dir * bill.speed
		
		owner.add_child(bill)
		
		# This prevents the gun or player from affecting the transform of the bullet.
		
		bill.set_as_top_level(true)
		
		bill.set_collision_layer(4)
		bill.set_collision_mask(8+16)
		bill.team = "player"
		
		# Owner.position here b/c Gun's position is (0,0)
		bill.position = owner.position + (dir * 15)
		
		bill.look_at(get_global_mouse_position())
		
		ammo_cur -= 1
		
		_update_label()
		
		$AudioStreamPlayer2D.play()
		
		if(ammo_cur == 0 and canReload):
			reloading = true
			reload_time_cur = 0

func _update_label():
	ammo_label.text = str(ammo_cur)

func add_ammo(count : int):
	ammo_cur = clamp(ammo_cur + count, 0, ammo_max)
	_update_label()
	
func _on_ammo_return():
	add_ammo(1)
