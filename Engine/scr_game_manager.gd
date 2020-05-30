# This node is intended to be the root 
extends Node

func on_waves_finished () :
	game_complete()

func game_complete () :
	#TODO: Transition to end game screen 
	get_tree().quit()
