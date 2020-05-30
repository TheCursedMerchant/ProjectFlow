# Test entity for collision 
extends "res://scripts/entities/scr_entity.gd"
var points = 100
var spawner

signal entity_died

func take_damage(damage : int):
	health_points -= damage
	
func _process(delta): 
	if ( health_points <= 0 ):
		die()
		
func die() :
	emit_signal("entity_died")
	global.current_score += points
	queue_free()

func _on_Hurtbox_body_entered(body):
	if (body.is_in_group("Player") && body.dash_hit ):
		body.emit_signal("player_shake", .35 , 20, 20) 
		take_damage(body.dash_damage)
