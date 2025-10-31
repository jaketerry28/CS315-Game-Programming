extends StaticBody2D

signal reward

var can_interact : bool = false
var is_open : bool = false

@export var chest_name : String


func _ready() -> void:
	if GameController.opened_chests.has(chest_name):
		is_open = true
		$AnimatedSprite2D.play("open")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		if not is_open:
			open_chest()

func open_chest():
	$AudioStreamPlayer2D.play()
	get_tree().paused = true
	is_open = true
	$AnimatedSprite2D.play("open")
	$Sword.visible = true
	$Timer.start()
	reward.emit()
	GameController.has_weapon = true
	GameController.opened_chests.append(chest_name)
	
func _on_timer_timeout() -> void:
	get_tree().paused = false
	$Sword.visible = false
