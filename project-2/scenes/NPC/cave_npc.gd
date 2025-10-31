extends StaticBody2D

signal give_key

var can_interact : bool = false
var gives_key : bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		$AudioStreamPlayer2D.play()
		if $DialogueBox.visible:
			$DialogueBox.visible = false
			get_tree().paused = false
			give_key.emit()
		else:
			$DialogueBox.visible = true
			get_tree().paused = true
