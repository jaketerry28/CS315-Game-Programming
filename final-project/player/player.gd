extends CharacterBody2D

var bullet = preload("res://scene/bullet.tscn")
var player_death_effect = preload("res://player/player_death/player_death_effect.tscn")

@onready var death_sound: AudioStreamPlayer2D = $DeathSound
@onready var animation_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var muzzle : Marker2D = $Muzzle
@onready var hit_animation = $HitAnimationPlayer
@onready var shoot_sound: AudioStreamPlayer2D = $ShootSound
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

@export var gravity : float = 1000
@export var speed : float = 1000
@export var max_horizontal_speed : int = 300
@export var jump : float = -350
@export var jump_horizontal_speed : float = 1000
@export var max_jump_horizontal_speed : int = 300
@export var slow_down_speed : int = 2000

var player_jumps : int = 2
enum State {Idle, Run, Jump, Shoot}

var current_state : State
var muzzle_position
var direction

func _ready():
	current_state = State.Idle
	muzzle_position = muzzle.position

func _physics_process(delta: float) -> void:
	player_falling(delta)
	player_idle(delta)
	player_run(delta)
	player_jump(delta)
	player_shooting(delta)
	player_muzzle_position()
	
	move_and_slide()

	player_animation()

func player_falling(delta: float):
	if !is_on_floor():
		velocity.y += gravity * delta
	else:
		player_jumps = 2

func player_idle(delta: float):
	if is_on_floor() and current_state != State.Shoot:
		current_state = State.Idle
		
func player_run(delta: float):
	direction = input_movement()
	
	if direction:
		velocity.x += direction * speed * delta
		velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)
	else:
		velocity.x = move_toward(velocity.x, 0, 1000)

	if direction != 0 and is_on_floor() and current_state != State.Shoot:
		current_state = State.Run
		
func player_jump(delta: float):
	if player_jumps > 0:
		if Input.is_action_just_pressed("jump"):
			current_state = State.Jump
			velocity.y = jump
			player_jumps -= 1
			jump_sound.play()

	if is_on_floor() and current_state == State.Jump:
		direction = input_movement()
		velocity.x += direction * jump_horizontal_speed * delta
		velocity.x = clamp(velocity.x, -max_jump_horizontal_speed, max_jump_horizontal_speed)

func player_shooting(delta):
	var shoot_direction: int = input_movement()

	if Input.is_action_just_pressed("shoot"):
		if shoot_direction == 0:
			shoot_direction = -1 if animation_sprite.flip_h else 1

		var bullet_instance = bullet.instantiate() as Node2D
		bullet_instance.direction = shoot_direction
		bullet_instance.global_position = muzzle.global_position
		get_parent().add_child(bullet_instance)
		
		shoot_sound.play()   
		current_state = State.Shoot

	# Check if the shoot button is released and the player is stationary
	if Input.is_action_just_released("shoot") and is_on_floor() and velocity.x == 0:
		current_state = State.Idle

func player_muzzle_position():
	var direction = input_movement()
	
	if direction > 0:
		muzzle.position.x = muzzle_position.x
	elif direction < 0:
		muzzle.position.x = -muzzle_position.x
		
func player_animation():
	if velocity.x > 0:
		animation_sprite.flip_h = false
	elif velocity.x < 0:
		animation_sprite.flip_h = true

	# Change the animation based on the current state
	if current_state == State.Idle:
		animation_sprite.play("idle")
	elif current_state == State.Jump:
		animation_sprite.play("jump")
	elif current_state == State.Run:
		animation_sprite.play("run")
	elif current_state == State.Shoot:
		if abs(velocity.x) > 0:
			animation_sprite.play("run_and_shoot")
		else:
			animation_sprite.play("shoot")
		
		
func input_movement():
	var direction = Input.get_axis("left","right")
	return direction


func player_death():
	death_sound.play()
	var player_death_effect_instance = player_death_effect.instantiate() as Node2D
	player_death_effect_instance.global_position = global_position
	get_parent().add_child(player_death_effect_instance)
	queue_free()

func _on_hurtbox_body_entered(body : Node2D):
	if body.is_in_group("Enemy"):
		print("Enemy entered !", body.damage_amount)
		hit_animation.play("hit")
		HealthManager.decrease_health(body.damage_amount)
		
	if HealthManager.current_health == 0:
		player_death()
