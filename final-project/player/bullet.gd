extends AnimatedSprite2D

var bullet_impact_effect = preload("res://scene/bullet_impact_effect.tscn")

var speed : int = 600
var direction : int
var damage : int = 1

func _physics_process(delta: float) -> void:
	move_local_x(direction * speed * delta)
	
func _on_timer_timeout() -> void:
	queue_free()


func _on_hitbox_area_entered(area: Area2D) -> void:
	bullet_impact()
	print("Area Entered") # Replace with function body.

func _on_hitbox_body_entered(body: Node2D) -> void:
	bullet_impact()
	print("Body Entered")

func bullet_impact():
	var bullet_impact_effect_instance = bullet_impact_effect.instantiate() as Node2D
	bullet_impact_effect_instance.global_position = global_position
	get_parent().add_child(bullet_impact_effect_instance)
	
	queue_free()

func get_damage_amount() -> int:
	return damage
