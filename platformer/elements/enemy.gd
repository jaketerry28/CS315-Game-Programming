extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var state = "idle"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	#figure out what direction the player is in
	var player_dir = self.position - get_tree().get_nodes_in_group("player")[0].position
	
	if player_dir.length() < 120:
		state = "chase"
	else:
		state = "idle"

	
	if (state == "chase"):
		self.velocity.x = -player_dir.normalized().x * SPEED 
	
	self.velocity.x *= 0.9
	move_and_slide()
