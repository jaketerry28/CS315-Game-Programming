extends Node

const CAVE_LEVEL = preload("res://levels/cave_level.tscn")
const PauseMenuScreen = preload("res://ui/pause_menu_screen.tscn")
const MAIN_MENU = preload("res://ui/main_menu.tscn")

func _ready():
	RenderingServer.set_default_clear_color(Color(0.44,0.12,0.53,1.00))

func start_game():
	if get_tree().paused:
		continue_game()
		return
	
	transition_to_scene(CAVE_LEVEL.resource_path)

func exit_game():
	get_tree().quit()

func pause_game():
	get_tree().paused = true
	
	var pause_menu_screen_instance = PauseMenuScreen.instantiate()
	get_tree().get_root().add_child(pause_menu_screen_instance)

func continue_game():
	get_tree().paused = false


func main_menu():
	var main_menu_screen_instance = MAIN_MENU.instantiate()
	get_tree().get_root().add_child(main_menu_screen_instance)
	
func transition_to_scene(scene):
	await get_tree().create_timer(.1).timeout
	get_tree().change_scene_to_file(scene)
	
