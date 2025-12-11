extends Area2D

@export var target_level: String
@export var disable_player_on_enter := true

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return

	if disable_player_on_enter:
		body.set_physics_process(false)

	LevelTransition.transition_to(target_level)
