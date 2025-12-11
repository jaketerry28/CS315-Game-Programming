extends Node2D

@export var pickup_amount : int = 1

@onready var pickup_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_health_pickup_box_body_entered(body):
	if body.is_in_group("Player"):
		HealthManager.increase_health(pickup_amount)

		pickup_sound.play()

		# Disable collision so it can't trigger again
		$HealthPickupBox.set_deferred("monitoring", false)

		# Wait for sound to finish BEFORE deleting
		pickup_sound.finished.connect(queue_free)
