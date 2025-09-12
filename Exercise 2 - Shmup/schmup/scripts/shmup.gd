extends Node2D

var score = 0
@export var txt_score : Label

func _ready() -> void:
	txt_score.text = str(score)
	
func increment_score():
	score = score + 1
	txt_score.text = str(score)
	
	# do the sound
	$SFXExplosion.play()
