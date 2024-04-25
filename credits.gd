extends Control


func _ready():
	$Sprite2D/animaciones.play("credits")



func _process(delta):
	pass


func _on_back_pressed():
	var start_screen = load("res://start_screen.tscn")
	if start_screen:
		var start_instance = start_screen.instantiate()
		self.get_parent().add_child(start_instance)
		self.queue_free()
	else:
		print("Error al cargar la escena")
