extends Area2D

@export var single_use : bool = false

@onready var animation = $AnimatedSprite2D

var bodies_on_pressure_plate = 0

signal pressed
signal unpressed

func _on_body_entered(body: Node2D) -> void:
	bodies_on_pressure_plate += 1
	if body.is_in_group("pushable") or body is Player:
		if bodies_on_pressure_plate == 1:
			$AudioStreamPlayer2D.play()
			pressed.emit()
			animation.play("pressed")
	
func _on_body_exited(body: Node2D) -> void:
	if single_use:
		return
	bodies_on_pressure_plate -= 1
	if body.is_in_group("pushable") or body is Player:
		if bodies_on_pressure_plate == 0:
			$AudioStreamPlayer2D.play()
			unpressed.emit()
			animation.play("unpressed")
			
