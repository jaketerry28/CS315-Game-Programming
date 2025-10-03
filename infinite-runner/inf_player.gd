extends CharacterBody2D

var jump_power = 700
var is_hurt = false

func _on_animated_sprite_2d_animation_finished() -> void:
	is_hurt = false


func hurt():
	is_hurt = true
	$AnimatedSprite2D.play("hurt")
	$SFX/crash.play()

func _process(delta: float) -> void:
	# fall
	self.velocity.y += get_gravity().y * delta
	
	# check if you have positive velocity...
	if is_on_floor() and !is_hurt:
		$AnimatedSprite2D.play("default")
	
	# jump
	if (Input.is_action_just_pressed("jump")):
		self.velocity.y = -jump_power
		$AnimatedSprite2D.play("jump")
		$SFX/jump.play()
		
	move_and_slide()
	
