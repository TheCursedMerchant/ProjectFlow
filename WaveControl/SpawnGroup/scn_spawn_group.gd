extends Node2D

export var num_waves = 2

var current_wave = 0
var can_spawn_wave = true
var spawn_count = 0

onready var wave_timer = $WaveTimer

var active = false

signal wave_complete

func spawn_wave() :
	active = true
	can_spawn_wave = false
	current_wave += 1
	for spawner in get_children() :
		if (spawner.has_method("spawn") ):  
			spawner.spawn()
		
func check_spawn_status() :
	if current_wave < num_waves : 
		for spawner in get_children() :
			if spawner.has_method("spawn") && !spawner.can_spawn :
				return false
		return true
	else :
		return false

func _on_spawn_updated() :
	can_spawn_wave = check_spawn_status()
	if can_spawn_wave : 
		wave_timer.start()
	elif (spawn_count == 0) : 
		emit_signal("wave_complete")
	
func _on_WaveTimer_timeout():
	spawn_wave()

func _on_TriggerBox_body_entered(body):
	if( body.is_in_group("Player") && !active) : 
		wave_timer.start()
