extends Node2D

var Crunch
var Enter
var Loser
var BackGround
var is_muted = false

func _ready():
	Crunch = $CrunchSound
	Enter = $EnterSound
	Loser = $LoserSound
	BackGround = $BackgroundSound
	is_muted = GLOBAL.is_muted
	
func go_player(track):
	if is_muted == false:
		var track_name = track
		play_music(track_name)
	else:
		print("silencio")
		return
		
func play_music(track_name):
	if is_muted == true:
		print("La musica esta silenciada o la pista no existe.")
	if is_muted == false:
		if track_name == "background":
			BackGround.play()
		if track_name == "start_game":
			Enter.play()
		if track_name == "eat":
			Crunch.play()
		if track_name == "lose":
			Loser.play()
	
		
func _process(_delta):
	pass
