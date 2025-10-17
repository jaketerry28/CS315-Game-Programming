extends CharacterBody2D

@export var speed = 100
@onready var anim_tree = $AnimationTree

var facing = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var dir = Input.get_vector("left", "right", "up", "down")
	
	self.velocity = dir * speed #yes you should actually multiply by delta but i am lazy too
	if dir.x < 0 and facing == 1:
		self.scale.x *=-1
		facing = -1
		
	if dir.x > 0 and facing == -1:
		self.scale.x *=-1
		facing = 1
	
	
	if velocity.length() > 0.01:
		anim_tree['parameters/conditions/walk'] = true
		anim_tree['parameters/conditions/idle'] = false
	else:
		anim_tree['parameters/conditions/walk'] = false
		anim_tree['parameters/conditions/idle'] = true

	if Input.is_action_just_pressed("attack"):
		anim_tree['parameters/conditions/attack'] = true
	else:
		anim_tree['parameters/conditions/attack'] = false


	move_and_slide()


func _on_attack_region_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		var dir = self.global_position - body.global_position
		body.hit(dir)
	pass # Replace with function body.
