extends CharacterBody2D
@onready var sfx_laser: AudioStreamPlayer2D = $"../SFXLaser"

var speed = 450

@export var bullet_element : Resource
#var bullet_element = preload("res://elements/laser.tscn")

func _process(delta: float) -> void:
	var move_dir = Input.get_axis("left","right")
	
	self.velocity.x = move_dir * speed
	
	if Input.is_action_just_pressed("shoot"):
		# make the scene exist
		var new_bullet = bullet_element.instantiate()
		
		
		# put it onto the screen
		get_node("/root").add_child(new_bullet)
		sfx_laser.play()
		new_bullet.position = self.position
	move_and_slide()
