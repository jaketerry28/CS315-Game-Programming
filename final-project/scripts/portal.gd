extends Area2D

@export var next_level: String
const CAVE_LEVEL = preload("res://levels/cave_level.tscn")


func _on_body_entered(body):
	print("PORTAL HIT")
	if body.is_in_group("Player"):
		print("CALLING GAMEMANAGER")
		GameManager.transition_to_scene(CAVE_LEVEL.resource_path)
