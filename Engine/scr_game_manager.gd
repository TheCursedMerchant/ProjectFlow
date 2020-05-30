# This node is intended to be the root 
extends Node

var scn_game_over = preload("res://GUI/GameOverMenu/scn_game_over_menu.tscn")

func on_waves_finished () :
	game_complete()

func game_complete () :
	# Create Game Over Menu on the screen
	# TODO: Disable Player Input
	var game_over_instance = scn_game_over.instance(0)
	add_child(game_over_instance)
