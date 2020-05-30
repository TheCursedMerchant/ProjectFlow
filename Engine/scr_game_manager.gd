# This node is intended to be the root 
extends Node

var scn_game_over = preload("res://GUI/GameOverMenu/scn_game_over_menu.tscn")
var end_game_timer = Timer.new()
var end_game_time = 3.0

func _ready() :
	end_game_timer.one_shot = true 
	end_game_timer.wait_time = end_game_time
	end_game_timer.connect("timeout", self, "on_end_game_timeout")
	add_child(end_game_timer)
	for child in get_children() :
		if child.is_in_group("WaveController") : 
			child.connect("wave_finished", self, "on_waves_finished")

func on_waves_finished () :
	end_game_timer.start()

func game_complete () :
	global.goto_scene(global.path_game_over_menu)
	
func on_end_game_timeout () :
		game_complete()
