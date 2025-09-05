extends Area2D


func _on_body_entered(body: Node2D) -> void:
	get_node("/root/Pong/Ball").reset_ball()
	get_node("/root/Pong").increment_score()
	
