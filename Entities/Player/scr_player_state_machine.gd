extends "res://Entities/StateControl/scr_state_machine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"move": $Move,
		"dash": $Dash
	}