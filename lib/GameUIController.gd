extends CanvasLayer

@onready var timeLabel : Label = $HBoxContainer/TimeLabel
var timeText : String = "Time: "
@onready var scoreLabel : Label = $HBoxContainer/ScoreLabel
var scoreText : String = "Score: "

func _ready():
	reset()
	
func _process(delta):
	update()
	
func reset():
	timeLabel.text = timeText + str(0)
	scoreLabel.text = scoreText + str(0)

func update():
	# snapped is the updated name for stepify
	# it takes an into and snaps it to the specified decimal place
	# 0.01 puts a number at two decimals
	timeLabel.text = timeText + str(snapped(GameDifficulty.timer, 0.01))
	scoreLabel.text = scoreText + str(GameDifficulty.playerScore)
