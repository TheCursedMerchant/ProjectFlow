extends VBoxContainer

func _on_Start_pressed():
	global.goto_scene(global.path_start_scene)

func _on_Quit_pressed():
	get_tree().quit()
