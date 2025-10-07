extends Node

@export var pipe_scene : PackedScene

var game_running : bool
var game_over : bool
var scroll : int
var score : int
const SCROLL_SPEED : int = 2
var screen_size : Vector2i
var ground_height : int
var pipes : Array
const PIPE_DELAY : int = 100
const PIPE_RANGE : int = 200
var scroll_speed : float = SCROLL_SPEED
var speed_increase_rate : float = 0.1  # units per second

# for the background 
var elapsed_time = 0.0
@onready var background = $AutoScroller/BackFixedTexture.material
@onready var midground = $AutoScroller/TextureRectMiddle.material
@onready var foreground = $AutoScroller/TextureRectForeground.material


func _process(delta: float) -> void:
	if game_running:
		# Update background shader
		elapsed_time += delta
	
		background.set_shader_parameter("elapsed_time", elapsed_time)
		midground.set_shader_parameter("elapsed_time", elapsed_time)
		foreground.set_shader_parameter("elapsed_time", elapsed_time)
		
		# Gradually increase scroll speed
		scroll_speed += speed_increase_rate * delta
		
		# Move ground
		scroll += scroll_speed
		if scroll >= screen_size.x:
			scroll = 0
		$Ground.position.x = -scroll 
		
		# Move pipes
		for pipe in pipes:
			pipe.position.x -= scroll_speed

func _ready() -> void:
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()
	
func new_game():
	game_running = false
	game_over = false
	score = 0
	$Score.text = "SCORE: " + str(score)
	$GameOver.hide()
	scroll = 0
	scroll_speed = SCROLL_SPEED  # reset to default
	get_tree().call_group("pipes", "queue_free")
	pipes.clear()
	generate_pipes()
	$Bird.reset()
	$AutoScroller/AudioStreamPlayer.play()

	
func _input(event):
		if game_over == false:
			if event is InputEventMouseButton:
				if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
					if game_running == false:
						start_game()

					else:
						if 	$Bird.is_flying:
							$Bird.flap()
							check_off_top_screen()

func start_game():
	game_running = true
	$Bird.is_flying = true
	$Bird.flap()
	$PipeSpawner.start()

	
func _on_pipe_spawner_timeout() -> void:
	generate_pipes()

func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.y - ground_height / 2 + randi_range(-PIPE_RANGE, PIPE_RANGE) )
	pipe.hit.connect(bird_hit)
	pipe.scored.connect(scored_point)
	add_child(pipe)
	pipes.append(pipe)

func scored_point():
	score += 1
	$Score.text = "SCORE: " + str(score)

func check_off_top_screen():
	if $Bird.position.y < -5:
		$Bird.is_falling = true
		stop_game()

func stop_game():
	$PipeSpawner.stop()
	$Bird.is_flying = false
	$AutoScroller/AudioStreamPlayer.stop()
	$GameOver.show()
	game_running = false
	game_over = true
	
func bird_hit():
	$Bird.is_falling = true
	stop_game()
	


func _on_ground_hit() -> void:
	$Bird.is_falling = true
	stop_game()
	


func _on_game_over_restart() -> void:
	new_game()
