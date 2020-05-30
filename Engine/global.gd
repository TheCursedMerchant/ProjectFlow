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

# Developer Mode
var dev_mode_enabled = true
var devTool