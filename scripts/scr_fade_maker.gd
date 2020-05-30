extends Node2D

# Makes fade away objects 
var scn_fader = preload("res://scenes/scn_fade_away.tscn")
export ( Texture ) var fade_texture
onready var fade_timer = $FadeTimer
onready var fade_delay = $FadeDelay
var is_fading = false

func repeat_fade(fade_time, fade_frequency): 
	fade_timer.wait_time = fade_time
	fade_delay.wait_time = fade_frequency
	fade_timer.start()
	fade_delay.start()

func create_fade():
	var current_fader = scn_fader.instance(0)
	current_fader.texture = get_parent().get_node("Sprite").texture
	current_fader.global_position = global_position
	get_tree().get_root().add_child(current_fader)

func _on_FadeTimer_timeout():
	is_fading = false
	fade_delay.stop()

func _on_FadeDelay_timeout():
	create_fade()
