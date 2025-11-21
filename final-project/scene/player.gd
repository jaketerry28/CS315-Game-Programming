extends CharacterBody2D

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D

@export var gravity : float = 1000
@export var speed : float = 300
@export var jump : float = -300
@export var jump_horizontal : float = 100

enum State {Idle, Run, Jump}

var current_state : State
var direction

func _ready():
	current_state = State.Idle

func _physics_process(delta: float) -> void:
	player_falling(delta)
	player_idle(delta)
	player_run(delta)
	player_jump(delta)
	
	
	move_and_slide()
	
	player_animation()


func player_falling(delta: float):
	if !is_on_floor():
		velocity.y += gravity * delta

func player_idle(delta: float):
	if is_on_floor():
		current_state = State.Idle
		
func player_run(delta: float):
	direction = input_movement()
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, 300)

	if direction != 0 and is_on_floor():
		current_state = State.Run
		
func player_jump(delta: float):
	if Input.is_action_just_pressed("jump"):
		current_state = State.Jump
		velocity.y = jump
	
	if is_on_floor() and current_state == State.Jump:
		direction = input_movement()
		velocity.x += direction * jump_horizontal * delta
		
func player_animation():
	if velocity.x > 0:
		animation.flip_h = false
	elif velocity.x < 0:
		animation.flip_h = true
	if current_state == State.Idle:
		animation.play("idle")
	elif current_state == State.Jump:
		animation.play("jump")
	elif current_state == State.Run:

		animation.play("run")

func input_movement():
	var direction = Input.get_axis("left","right")
	
	return direction
