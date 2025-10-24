extends Camera3D

@export var follow_target : Node3D
@export var offset : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.global_position = lerp(self.global_position, follow_target.global_position + offset, .1)
	self.look_at(follow_target.global_position)
	pass
