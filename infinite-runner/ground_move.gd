extends StaticBody2D

var move_speed = 100

func _process(delta: float) -> void:
		self.position.x -= move_speed * delta
