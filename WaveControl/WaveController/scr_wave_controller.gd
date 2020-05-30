# This node should only parent to Spawn Groups
# This node should only be a child of the root 
extends Node

onready var spawnGroups
onready var spawnCount
var complete_wave_count = 0

var game_manager

signal wave_finished

func _ready() : 
	spawnGroups = get_children()
	spawnCount = spawnGroups.size()
	for sg in spawnGroups :
		sg.connect("wave_complete", self, "on_wave_complete")

func on_wave_complete():
	complete_wave_count += 1
	if complete_wave_count == spawnCount : 
		emit_signal("wave_finished")
