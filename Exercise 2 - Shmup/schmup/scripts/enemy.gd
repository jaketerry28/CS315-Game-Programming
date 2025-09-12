extends CharacterBody2D

@export var move_dir = Vector2(0,0)


func _ready() -> void:
	self.velocity = move_dir
	
func _process(delta: float) -> void:
	move_and_slide()
