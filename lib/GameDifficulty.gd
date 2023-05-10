extends Node

var timer : float = 0
var scale : float = 1
var playerScore : int = 0

func start():
	set_physics_process(true)
	
func pause():
	set_physics_process(false)
	
func reset(_scale):
	scale = _scale
	timer = 0
	playerScore = 0
	
	pause()
	
func _ready():
	reset(1)
	
func _physics_process(delta):
	timer += delta
	
	scale = timer/60 + 1

func add_score(val : int):
	playerScore += val
