extends CharacterBody2D

const GRAVITY = 1000
const MAX_VEL = 600
const FLAP_SPEED = -500
const START_POS  = Vector2(100,400)
var is_flying = false
var is_falling = false

func _ready():
	reset()
	
func reset():
	is_falling = false
	is_flying = false
	position = START_POS
	set_rotation(0)
	
func _physics_process(delta: float) -> void:
	if is_flying or is_falling:
		velocity.y += GRAVITY * delta
		
		#if bird go too fast
		if velocity.y > MAX_VEL:
			velocity.y = MAX_VEL
		
		#so he turns
		if is_flying:
			set_rotation(deg_to_rad(velocity.y * 0.05))
			$AnimatedSprite2D.play()
		#fall straight down	
		elif is_falling:
			set_rotation(PI/2)
			$AnimatedSprite2D.stop()
		move_and_collide(velocity * delta)
	else:
		$AnimatedSprite2D.stop()
		
func flap():
	velocity.y = FLAP_SPEED
