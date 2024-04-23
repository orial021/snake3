extends Area2D

var distance = 0
var direction = Vector2i()
var axis = Vector2i()
var last_direction = Vector2i.ZERO
@onready var ranges = $Rango
@onready var lever = $Lever
@onready var ratio = $RadioTotal.shape.radius
@onready var Joystick =  $joystick

func _ready():
	ranges.visible = false
	lever.visible = false
	
func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			distance = position.distance_to(event.position)
			if distance <= ratio:
				ranges.visible = true
				lever.visible = true
				lever.position = event.position - self.position
				direction = (position.direction_to(event.position))
				axis = get_direction()
		else:
			lever.position = Vector2.ZERO
			direction = Vector2i.ZERO
			axis = get_direction()
			ranges.visible = false
			lever.visible = false
	
		
	if event is InputEventScreenDrag:
		distance = position.distance_to(event.position) 
		if distance <= ratio:
			lever.position = event.position - self.position
			direction = position.direction_to(event.position)
			axis = get_direction()
		else:
			direction = position.direction_to(event.position)
			lever.position = position + (direction * ratio) - self.position
			axis = get_direction()
				
'''func get_direction() -> Vector2i:
	axis = Vector2i.ZERO
	if direction.length() > 0:
		var normalized_direction = direction.normalized()
		axis = Vector2i(normalized_direction.x, normalized_direction.y)
		if abs(axis.x) > abs (axis.y):
			axis.y = 0
			axis.x = int(axis.x > 0) - int(axis.x < 0)
		else:
			axis.x = 0
			axis.y = int(axis.y > 0) - int(axis.y < 0)
	return axis'''
	
func get_direction() -> Vector2i:
	axis = Vector2i.ZERO
	if direction.length() > 0:
		var angle = direction.angle()
		if angle >= -PI/4 and angle < PI / 4:
			axis = Vector2i(1, 0) #derecha
		elif angle >= PI/4 and angle <3 * PI / 4:
			axis = Vector2i(0, 1) #arriba
		elif angle >= -3 * PI /4 and angle < -PI / 4:
			axis = Vector2i(0, -1) # abajo
		else:
			axis = Vector2i(-1, 0)
		if axis == -last_direction:
			axis = last_direction
		else:
			last_direction = axis
	return axis
			

