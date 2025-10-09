extends Timer

func _ready():
	randomize()
	restart_with_random_time()

func restart_with_random_time():
	wait_time = randf_range(1.0, 1.6)
	start()

func _on_timeout():
	restart_with_random_time()
