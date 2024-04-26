extends Node
var SNAKE = 2
const APPLE = 1
const ROCK = 0
var apple_pos
var rock_positions = [place_rock()]
var snake_body = [Vector2i(5, 10), Vector2i(4, 10), Vector2i(3, 10)]
var score_pos = [Vector2i(25, 20), Vector2i(24, 20), Vector2i(23, 20), Vector2i(22, 20), Vector2i(25, 19), Vector2i(24, 20), Vector2i(23, 20), Vector2i(22, 20) ]
var snake_direction = Vector2i(1,0)
var add_apple = false
var apple_count = 0
var start_timer = 0.2
var last_drag_position = Vector2()
var drag_threshold = 200
@onready var screen_size = get_viewport().size
var new_wait_time = 0.2
var last_turn_time = 0.2
var turn_delay = 0.1
var can_turn = true
var max_score = 0


func _ready():
	apple_pos = place_apple()
	rock_positions = [place_rock()]
	draw_rocks()
	
func place_apple():
	randomize()
	var x = randi() % 25
	var y = randi() % 20
	return Vector2i(x,y)

func place_rock():
	randomize()
	var x = randi() % 25
	var y = randi() % 20
	return Vector2i(x,y)
	
func draw_apple():
	$SnakeApple.set_cell(0, Vector2i(apple_pos.x, apple_pos.y), APPLE, Vector2i(0,0))
	
func draw_rocks():
	for rock_pos in rock_positions:
		$SnakeApple.set_cell(0, Vector2i(rock_pos.x, rock_pos.y), ROCK, Vector2i(0, 0))
	
func draw_snake():
	for block_index in snake_body.size():
		var block = snake_body[block_index]
		if block_index == 0:
			var head_dir = relation2(snake_body[0], snake_body[1])
			if head_dir == 'right':
				$SnakeApple.set_cell(0, Vector2i(block.x,block.y), SNAKE, Vector2i(3, 1))
			if head_dir == 'left':
				$SnakeApple.set_cell(0, Vector2i(block.x,block.y), SNAKE, Vector2i(2, 0))
			if head_dir == 'top':
				$SnakeApple.set_cell(0, Vector2i(block.x,block.y), SNAKE, Vector2i(3, 0))
			if head_dir == 'bottom':
				$SnakeApple.set_cell(0, Vector2i(block.x,block.y), SNAKE, Vector2i(2, 1))
		elif block_index == snake_body.size() -1:
			var tail_dir = relation2(snake_body[-1], snake_body[-2])
			if tail_dir == 'right':
				$SnakeApple.set_cell(0, Vector2i(block.x,block.y), SNAKE, Vector2i(0, 0))
			if tail_dir == 'left':
				$SnakeApple.set_cell(0, Vector2i(block.x,block.y), SNAKE, Vector2i(1, 0))
			if tail_dir == 'top':
				$SnakeApple.set_cell(0, Vector2i(block.x,block.y), SNAKE, Vector2i(1, 1))
			if tail_dir == 'bottom':
				$SnakeApple.set_cell(0, Vector2i(block.x,block.y), SNAKE, Vector2i(0, 1))
		
		else:
			var previus_block = snake_body[block_index + 1] - block
			var next_block = snake_body[block_index -1] - block
			
			if previus_block.x == next_block.x:
				$SnakeApple.set_cell(0, Vector2i(block.x,block.y), SNAKE, Vector2i(4, 1))
			elif previus_block.y == next_block.y:
				$SnakeApple.set_cell(0, Vector2i(block.x,block.y), SNAKE, Vector2i(4, 0))
			
			else:
				if previus_block.x == -1 and next_block.y == -1 or next_block.x == -1 and previus_block.y == -1:
					$SnakeApple.set_cell(0, Vector2i(block.x,block.y), SNAKE, Vector2i(6, 1))
				elif previus_block.x == 1 and next_block.y == 1 or next_block.x == 1 and previus_block.y == 1:
					$SnakeApple.set_cell(0, Vector2i(block.x,block.y), SNAKE, Vector2i(5, 0))
				elif previus_block.x == -1 and next_block.y == 1 or next_block.x == -1 and previus_block.y == 1:
					$SnakeApple.set_cell(0, Vector2i(block.x,block.y), SNAKE, Vector2i(6, 0))
				elif previus_block.x == 1 and next_block.y == -1 or next_block.x == 1 and previus_block.y == -1:
					$SnakeApple.set_cell(0, Vector2i(block.x,block.y), SNAKE, Vector2i(5, 1))

func relation2(first_block: Vector2i, second_block: Vector2i):
	var block_relation = second_block - first_block
	if block_relation == Vector2i(-1, 0): return 'left'
	if block_relation == Vector2i(1, 0): return 'right'
	if block_relation == Vector2i(0, 1): return 'bottom'
	if block_relation == Vector2i(0, -1): return 'top'

func move_snake():
	if add_apple:
		delete_tiles(SNAKE)
		var body_copy = snake_body.slice(0, snake_body.size())
		var new_head = body_copy[0] + snake_direction
		body_copy.insert(0, new_head)
		snake_body = body_copy
		add_apple = false
	else:
		delete_tiles(SNAKE)
		var body_copy = snake_body.slice(0, snake_body.size()-1)
		var new_head = body_copy[0] + snake_direction
		body_copy.insert(0, new_head)
		snake_body = body_copy
	can_turn = true

func delete_tiles(id:int):
	var cells = $SnakeApple.get_used_cells_by_id(0, id)
	for cell in cells:
		$SnakeApple.set_cell(0, Vector2i(cell.x, cell.y), -1)

func _input(event):
	$joystick.last_direction = snake_direction
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_up"):
			if not snake_direction == Vector2i(0,1):
				snake_direction = Vector2i(0, -1)
		if Input.is_action_just_pressed("ui_right"):
			if not snake_direction == Vector2i(-1, 0):
				snake_direction = Vector2i(1, 0)
		if Input.is_action_just_pressed("ui_down"):
			if not snake_direction == Vector2i(0,-1):
				snake_direction = Vector2i(0, 1)
		if Input.is_action_just_pressed("ui_left"):
			if not snake_direction == Vector2i(1, 0):
				snake_direction = Vector2i(-1, 0)
	elif $joystick.axis != Vector2i.ZERO:
		snake_direction = $joystick.axis

func check_apple_eaten():
	if apple_pos == snake_body[0]:
		apple_pos = place_apple()
		add_apple = true
		$Audios.go_player("eat")
		apple_count += 1
		$Score.increment_score()
		if apple_count % 5 == 0: 
			rock_positions.append(place_rock())
			SNAKE += 2
			new_wait_time = $SnakeTrick.wait_time - 0.02
			if new_wait_time > 0.05:
				$SnakeTrick.wait_time -= 0.02
				$SnakeTrick.start()
		elif apple_count % 3 == 0:
			rock_positions.append(place_rock())
		if apple_count == 10:
			$TextureRect.texture = load("res://graphics/grass3.png")
		elif apple_count == 20:
			$TextureRect.texture = load("res://graphics/grass2.png")
			
func check_game_over():
	var head = snake_body[0]
	if head.x > 25 or head.x <0 or head.y >20 or head.y < 0:
		reset()
	elif head in rock_positions:
		reset()
	for block in snake_body.slice(1, snake_body.size()):
		if block == head:
			reset()
				
func reset():
	$Audios.go_player("lose")
	delete_tiles(SNAKE)
	SNAKE = 2
	snake_body = [Vector2i(5, 10), Vector2i(4, 10), Vector2i(3, 10)]
	snake_direction = Vector2i(1, 0)
	$Score.update_high_score()
	$Score.score = 0
	apple_count = 0
	$Score.update_score()
	$TextureRect.texture = load("res://graphics/grass.png")
	$SnakeTrick.wait_time = start_timer
	for rock_pos in rock_positions:
		$SnakeApple.set_cell(0, Vector2i(rock_pos.x, rock_pos.y), -1)
	rock_positions = [place_rock()]
	draw_rocks()

func _on_back_pressed():
	$Audios.go_player("Lose")
	if get_tree().paused == true:
		get_tree().paused = false
	var start_screen = load("res://start_screen.tscn")
	if start_screen:
		var start_instance = start_screen.instantiate()
		self.get_parent().add_child(start_instance)
		self.queue_free()
	else:
		print("Error al cargar la escena")

func _on_snake_trick_timeout():
	move_snake( )
	check_apple_eaten( )
	draw_apple( )
	draw_snake( )
	draw_rocks()
	
func _process(_delta):
	check_game_over()
	if apple_pos in snake_body or apple_pos in rock_positions or apple_pos in score_pos:
		apple_pos = place_apple()
	if rock_positions in snake_body or rock_positions in score_pos:
		rock_positions = place_rock()

func _on_pause_pressed():
	if get_tree().paused:
		get_tree().paused = false
		$Pause.text = "PAUSA"
	else:
		get_tree().paused = true
		$Pause.text = "REANUDAR"
