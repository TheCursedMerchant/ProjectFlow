extends Area2D

# Hurtboxes need an entity as a parent

func deal_damage(damage) :
	get_parent().take_damage(damage)
