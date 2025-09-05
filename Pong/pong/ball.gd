extends CharacterBody2D

# called once the object is instantiated
# part of the display system

var spawn_position = Vector2(580, 330)

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout

	self.velocity = Vector2(-2, 1)

func _process(delta: float) -> void:
	var collision = move_and_collide(self.velocity)
	
	if collision:
		self.velocity = velocity.bounce(collision.get_normal())

func reset_ball():
	await get_tree().create_timer(1.0).timeout
	position = spawn_position
