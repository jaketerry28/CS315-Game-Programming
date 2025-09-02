extends CharacterBody2D

# called once the object is instantiated
# part of the display system

func _ready() -> void:
	self.velocity = Vector2(-2, 1)

func _process(delta: float) -> void:
	var collision = move_and_collide(self.velocity)
	
	if collision:
		self.velocity = velocity.bounce(collision.get_normal())
