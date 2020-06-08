extends Node

# Global Script Properties 
var permanent = true

# Game Properties 
var current_score = 0

# Game Objects 
var main_camera
var player_orb

# Global GUI Props
var path_start_menu = "res://GUI/StartMenu/scn_start_menu.tscn"
var path_game_over_menu = "res://GUI/GameOverMenu/scn_game_over_menu.tscn"

# Scene Tracking
var path_start_scene = "res://Rooms/scn_tmp_room.tscn"
var path_last_room
onready var current_scene = weakref(get_tree().current_scene)

# Developer Mode
var dev_mode_enabled = true
var devTool

# Changing Scenes 
func goto_scene(path):
	clean_up_scene()
	var s = ResourceLoader.load(path)
	var new_scene = s.instance()
	get_tree().get_root().add_child(new_scene)
	get_tree().set_current_scene(new_scene)
	if (current_scene.get_ref()) :
		current_scene.get_ref().queue_free()
	current_scene = weakref(new_scene)
	
func reload_scene() :
	goto_scene(current_scene.get_ref().filename)
	
	
func clean_up_scene() :
	var scene_children = get_tree().get_root().get_children()
	for child in scene_children : 
		if child.is_in_group("Clean") :
			child.queue_free() 
			