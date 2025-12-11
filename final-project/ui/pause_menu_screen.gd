extends CanvasLayer

func _on_continue_pressed() -> void:
	GameManager.continue_game()
	queue_free()

func _on_main_menu_pressed() -> void:
	GameManager.main_menu()
	queue_free()
