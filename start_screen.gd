extends Control

func _ready():
	if GLOBAL.is_muted == true:
		$MuteButton.button_pressed = true
	'''GLOBAL.is_muted == false:
		$MuteButton.toggled = false'''
		
func _on_play_pressed():
	$Audios.go_player("start_game")
	var main_game = load("res://main_game.tscn")
	if main_game:
		var main_instance = main_game.instantiate()
		self.queue_free()
		get_tree().root.add_child(main_instance)
	else:
		print("Error al cargar la escena")
		


func _on_credits_pressed():
	pass


func _on_mute_toggled(toggled_on):
	if toggled_on:
		GLOBAL.is_muted = true
		print("audio desactivado")
	else:
		GLOBAL.is_muted = false
		print("audio activado")
