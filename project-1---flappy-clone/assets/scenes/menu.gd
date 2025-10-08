extends CanvasLayer

signal start_game
signal end_game


func _on_start_pressed() -> void:
	start_game.emit()


func _on_quit_pressed() -> void:
	end_game.emit()
