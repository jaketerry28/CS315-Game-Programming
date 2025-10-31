extends StaticBody2D

@export var keys_needed : int 
@export var door_name : String

var can_interact : bool = false
var is_open : bool = false

signal open_door

func _ready() -> void:
	if GameController.opened_doors.has(door_name):
		is_open = true
		$CollisionShape2D.set_deferred("disabled", true)
		$Sprite2D.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		if not is_open and GameController.keys >= keys_needed:
			open_cave_door()

func open_cave_door():
	open_door.emit()
	is_open = true
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.visible = false
	GameController.opened_doors.append(door_name)
	
	
func _on_open_door() -> void:
	GameController.use_key()
	print(GameController.keys)
