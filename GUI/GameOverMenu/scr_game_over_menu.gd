extends VBoxContainer

func _on_Restart_pressed():
	get_tree().change_scene(global.path_start_scene)
	queue_free()
	
func _on_Quit_pressed():
	get_tree().quit()
	
func _on_Menu_pressed():
	get_tree().change_scene(global.path_start_menu)
	queue_free()
