extends CharacterBody2D

class_name  Player

@export var move_speed : float
@export var pushing_strength : float

@onready var animate = $AnimatedSprite2D
@onready var interact_area = $InteractArea

var is_attacking : bool = false

func _ready():
	update_hp_bar()
	if GameController.player_spawn_pos != Vector2(0,0):
		position = GameController.player_spawn_pos
	
func _physics_process(delta: float) -> void:
	if not is_attacking:
		move_player()
	
	move_block()
	
	move_and_slide()

	$UI/Panel/Label.text = str(GameController.keys)
	
	if Input.is_action_just_pressed("attack") and GameController.has_sword:
		attack()
		
func move_player():
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = move_vector * move_speed
	
	if velocity.x > 0:
		animate.play("move_right")
		interact_area.position = Vector2(8,0)
		
	elif velocity.x < 0:
		animate.play("move_left")
		interact_area.position = Vector2(-8,0)
		
	elif velocity.y > 0:
		animate.play("move_down")
		interact_area.position = Vector2(0,8)
		
	elif velocity.y < 0:
		animate.play("move_up")
		interact_area.position = Vector2(0,-8)
		
	else:
		animate.stop()	
	
func move_block():
	# Get last collision
	# Check for block
	# If block, make it move or something
	var collision : KinematicCollision2D = get_last_slide_collision()
	
	if collision:
		var collider_node = collision.get_collider()
		
		if collider_node.is_in_group("pushable"):
			# get the normal direction
			var collsion_normal : Vector2 = collision.get_normal()
			# push block
			collider_node.apply_central_force(-collsion_normal * pushing_strength)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		body.can_interact = true
		if body.is_in_group("gives_key"):
			body.gives_key = true
			
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		body.can_interact = false
		
func _on_treasure_chest_reward() -> void:
	animate.play("reward")
	GameController.has_sword = true

func _on_cave_npc_give_key() -> void:
	GameController.collect_key()
	animate.play("reward")
	$Key.visible = true
	$KeyTimer.start()

func _on_timer_timeout() -> void:
	$Key.visible = false

func _on_hitbox_body_entered(body: Node2D) -> void:
	GameController.player_hp -= 1
	update_hp_bar()
	if GameController.player_hp <= 0:
		die()
	
func die():
	GameController.player_hp = 3
	get_tree().call_deferred("reload_current_scene")
	
func update_hp_bar():
	if GameController.player_hp >= 3:
		%HPBar.play("3hp")
	elif GameController.player_hp == 2:
		%HPBar.play("2hp")
	elif GameController.player_hp == 1:
		%HPBar.play("1hp")
	else:
		%HPBar.play("0hp")

func _on_sword_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()

func attack():
	velocity = Vector2(0,0)
	is_attacking = true
	$Sword.visible = true
	%SwordArea2D.monitoring = true
	$AttackTimer.start()
	
	var player_animation : String = animate.animation
	if player_animation == "move_right":
		animate.play("attack_right")
	elif player_animation == "move_left":
		animate.play("attack_left")
	elif player_animation == "move_up":
		animate.play("attack_up")
	elif player_animation == "move_down":
		animate.play("attack_down")
	
func _on_attack_timer_timeout() -> void:
	is_attacking = false
	$Sword.visible = false
	%SwordArea2D.monitoring = false
	
	var player_animation : String = animate.animation
	if player_animation == "attack_right":
		animate.play("move_right")
	elif player_animation == "attack_left":
		animate.play("move_left")
	elif player_animation == "attack_up":
		animate.play("move_up")
	elif player_animation == "attack_down":
		animate.play("move_down")
