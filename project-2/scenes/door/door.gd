extends StaticBody2D

@export var buttons_needed : int 

var buttons_pressed : int = 0

func _on_pressure_plate_pressed() -> void:
	buttons_pressed += 1
	if buttons_pressed >= buttons_needed:
		print(buttons_needed)
		visible = false
		$CollisionShape2D.set_deferred("disabled", true)



func _on_pressure_plate_unpressed() -> void:
	buttons_pressed -= 1
	if buttons_pressed <= buttons_needed:
		visible = true
		$CollisionShape2D.set_deferred("disabled", false)
