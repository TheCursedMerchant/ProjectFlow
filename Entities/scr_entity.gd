extends KinematicBody2D

export var health_points = 100
export var move_speed = 250 
var move_vector = Vector2(0, 0)

# Function should be implemented by inheriting class 
func take_damage(damage : int, direction: Vector2) :
	pass 