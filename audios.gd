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
	
	
func play_music(track_name):
	if is_muted == true:
		print("La musica esta silenciada o la pista no existe.")
	if is_muted == false:
		if track_name == "background":
			print('inicio del juego')
			BackGround.play()
		if track_name == "start_game":
			print('boton de inicio')
			Enter.play()
		if track_name == "eat":
			print("comer")
			Crunch.play()
		if track_name == "lose":
			print("perder")
			Loser.play()
	
		
func _process(_delta):
	pass
