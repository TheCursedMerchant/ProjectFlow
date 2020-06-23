extends KinematicBody2D

export var damage = 1
export var knock_back = 1500
export var knock_back_buffer = 10

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player") : 
		var hit_direction = body.position - position
		body.take_damage(damage, hit_direction.normalized() * knock_back)
