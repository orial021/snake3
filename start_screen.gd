extends Control

var is_muted 

func _ready():
	pass

		
func _on_play_pressed():
	var main_game = load("res://main_game.tscn")
	if main_game:
		var main_instance = main_game.instantiate()
		self.queue_free()
		get_tree().root.add_child(main_instance)
		$Audios.play_music("start_game")
		
	else:
		print("Error al cargar la escena")
		


func _on_credits_pressed():
	pass


func _on_mute_toggled(toggled_on):
	if toggled_on:
		is_muted = true
		print("audio desactivado")
	else:
		is_muted = false
		print("audio activado")
	$Audios.is_muted = is_muted
