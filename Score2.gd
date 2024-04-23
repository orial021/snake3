extends Label
@onready var screen_size = get_viewport().size
var score = 0

func _ready():
	update_score()
	
func increment_score():
	score += 1
	update_score()
	
func update_score():
	text = str(score)

func _process(_delta):
	$".".position = Vector2i(19, 22)


