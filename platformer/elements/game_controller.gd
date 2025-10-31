extends Node

var keys = 0

var coins_collected = 0
signal coin_collected

func collect_coin():
	coins_collected += 1
	coin_collected.emit()

func collect_key():
	keys += 1
	
func use_key():
	if keys > 0:
		keys -= 1
