extends Area2D

var move_speed = 100

func _process(delta: float) -> void:
	self.position.x -= move_speed * delta


func _on_body_entered(body: Node2D) -> void:
	body.hurt()
	pass
	
