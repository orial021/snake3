extends Control

@onready var screen_size = get_viewport().size
var score = 0
var score_file = ConfigFile.new()
var max_score = 0

func _ready():
	max_score = load_high_score()
	$HighScore.text = "HIGH SCORE: " + str(max_score)
	
func empty_label():
	$HighScore.text = ""
	
func load_high_score():
	score_file = ConfigFile.new()
	score_file.load("user://high_score.ini")
	return score_file.get_value("HighScore", "max_score", 0)
	
func increment_score():
	score += 1
	update_score()
	
func update_score():
	$Score.text = str(score)
	
func update_high_score():
	if score > max_score:
		empty_label()
		save_high_score(score)
	else:
		return
	$HighScore.text = "HIGH SCORE: " + str(max_score)
	
func save_high_score(score):
	if score > max_score:
		max_score = score
		score_file.load("user://high_score.ini")
		score_file.set_value("HighScore", "max_score", max_score)
		score_file.save("user://high_score.ini")
	
func _process(_delta):
	$Score.position = Vector2i(920, 720)
	$HighScore.position = Vector2i(20, 720)
