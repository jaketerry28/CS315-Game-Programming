extends CharacterBody2D

var health = 5
@onready var health_bar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func hit(hit_dir):
	self.velocity = hit_dir * 100
	health -= 1
	health_bar.value = health
	print(health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.velocity *= .9
	move_and_slide()
