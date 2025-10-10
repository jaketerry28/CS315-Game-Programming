extends Area2D

@export var keys_needed = 1
@export var scene_to_load : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if PlatformerGameController.keys >= keys_needed:
		get_tree().change_scene_to_file(scene_to_load)
	else:
		pass
