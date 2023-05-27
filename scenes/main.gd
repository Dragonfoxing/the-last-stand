extends Node2D

@export var player : Node2D
@export var camera : Camera2D
@export var spawnBoundary : SpawnBoundaryBox
@export var spawnDistance : int = 100
var width : int = 800
var height : int = 600
var rng : RandomNumberGenerator = RandomNumberGenerator.new()

@export var spawnCurve : Curve

@export var enemies : Array[EnemyListing]

@onready var SCREEN_PAUSE = $PauseScreen

var FLAG_GAME_PAUSED : bool = false

var tick_spawn_cur : int = 0
var tick_spawn_length : int = 30
var tick_spawn_length_max : int = tick_spawn_length

# Called when the node enters the scene tree for the first time.
func _ready():
	_reset_entities()

func _reset_entities():
	player.position = Vector2(width/2, height/2)
	camera.position = player.position
	tick_spawn_length = tick_spawn_length_max
	
	GameDifficulty.reset(1)
	GameDifficulty.start()
	
func _spawn_entity():
	var enemyChoice = rng.randf_range(0, 1)
	
	for listing in enemies:
		if(enemyChoice >= listing.spawn_range.x and enemyChoice < listing.spawn_range.y):
			var enemy = listing.scene.instantiate()
			enemy.position = _get_random_position_for_entity()
			enemy.target = player
			#enemy.speed = enemy.speed * (1 + GameDifficulty.scale / 4)
			enemy.speed = 0
			add_child(enemy)
			
	
func _get_random_position_for_entity():
	
	var _xy = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1))
	var _dist = Vector2(rng.randf_range(spawnBoundary.spawnDistance, spawnBoundary.boundsDistance), 0)
	
	var _pos = _dist.rotated(_xy.angle())
	
	print(_xy, _dist, _pos)
	_pos += player.position
	
	return _pos
	
func _physics_process(delta):
	if(is_instance_valid(player) and not FLAG_GAME_PAUSED):
		#spawnBoundary.position = player.position
		
		tick_spawn_cur += 1
		if(tick_spawn_cur >= tick_spawn_length - spawnCurve.sample(clamp(GameDifficulty.timer/300, 0, 1))):
			tick_spawn_cur = 0
			# - clampf(((GameDifficulty.scale/2) / 20), 0, 0.5)
			# throw the above into the below if statement to make the game way harder
			if (rng.randf() >= 0.5):
				_spawn_entity()
	else:
		# the game has ended
		GameDifficulty.pause()
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and is_instance_valid(player):
		if(not FLAG_GAME_PAUSED):
			FLAG_GAME_PAUSED = true
			get_tree().call_group("game_entities", "pause")
			SCREEN_PAUSE.show()
			GameDifficulty.pause()
		elif(FLAG_GAME_PAUSED):
			FLAG_GAME_PAUSED = false
			get_tree().call_group("game_entities", "unpause")
			SCREEN_PAUSE.hide()
			GameDifficulty.start()
			
	elif event.is_action_pressed("reload_scene"): 
		$AudioStreamPlayer2D.play()
		SCREEN_PAUSE.hide()
		GameDifficulty.pause()
		get_tree().call_group("game_entities", "pause")
		await $AudioStreamPlayer2D.finished
		get_tree().reload_current_scene()
	
# This lets the game handle any custom quit functionality.
# In theory every notification handler will be called before we quit(0)
func _send_quit_request():
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit(0)
