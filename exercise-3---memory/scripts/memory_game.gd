extends Node2D

var selected_cards : Array
var cards_match = false

func _ready() -> void:
	selected_cards = []



func card_clicked(selected_card):
	# game logic
	selected_cards.append(selected_card)
	
	if selected_cards.size() >= 2:
		$FlipTimer.start()
		# do the check
		if selected_cards[0].card_value == selected_cards[1].card_value:
			cards_match = true
		else:
			cards_match = false
	pass
	


func _on_flip_timer_timeout() -> void:
	if cards_match:
		selected_cards[0].queue_free()
		selected_cards[1].queue_free()
	else:
		selected_cards[0].flip()
		selected_cards[1].flip()
		
	selected_cards = []
