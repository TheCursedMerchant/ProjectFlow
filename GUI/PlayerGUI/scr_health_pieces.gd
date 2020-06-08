extends HBoxContainer

onready var fill_texture = "res://GUI/PlayerGUI/spr_health_ui2.png"
onready var empty_texture = "res://GUI/PlayerGUI/spr_health_ui1.png"
onready var health_pieces = get_children()

signal update_health
	
func _on_player_health_updated(current_health) :
	var health_count = 0
	for piece in health_pieces :
		health_count += 1
		if health_count <= current_health : 
			 piece.texture = load(fill_texture)
		else :
			piece.texture = load(empty_texture)
