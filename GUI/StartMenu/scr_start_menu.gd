extends VBoxContainer

var start_scene_path = "res://Rooms/scn_tmp_room.tscn"

func _on_Start_pressed():
	get_tree().change_scene(start_scene_path)

func _on_Quit_pressed():
	get_tree().quit()
