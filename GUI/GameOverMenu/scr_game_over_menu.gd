extends CanvasLayer

onready var menu = $GameOverMenu

func _on_Restart_pressed():
	global.current_score = 0
	global.goto_scene(global.path_start_scene)
	
func _on_Quit_pressed():
	get_tree().quit()
	
func _on_Menu_pressed():
	global.goto_scene( global.path_start_menu )
