extends "res://Entities/Player/States/scr_movement.gd"

func enter () :
	target.trail.emitting = true
	target.move_vector = Vector2() 
	target.move_direction = get_input_direction()
	target.move_vector += get_input_direction() * target.move_speed

func update(delta) :
	target.move_vector = target.move_and_slide(target.move_vector)
	
	if Input.is_action_pressed("ui_dash") && target.can_dash :
		emit_signal("finished", "dash")
		return
	
	if 	get_move_input() : 
		emit_signal("finished", "move")
	else : 
		emit_signal("finished", "idle")
		
func exit() :
	target.trail.emitting = false