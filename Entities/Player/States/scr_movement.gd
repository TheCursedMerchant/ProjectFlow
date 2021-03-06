extends "res://Entities/StateControl/scr_state.gd"

# Get the direction of our input
func get_input_direction():
	var input_direction = Vector2()
	if Input.is_action_pressed("ui_up") :
		input_direction.y = -1
#		target.sprite.flip_h = false
	if Input.is_action_pressed("ui_down") :
		input_direction.y = 1
#		target.sprite.flip_h = false
	if Input.is_action_pressed("ui_left") :
		input_direction.x = -1
#		target.sprite.flip_h = true
	if Input.is_action_pressed("ui_right") :
		input_direction.x = 1
#		target.sprite.flip_h = false
	return input_direction
	
func get_move_input() :
# Check if any movement inputs have been pressed
	if Input.is_action_pressed("ui_up") :
		return true
	if Input.is_action_pressed("ui_down") :
		return true
	if Input.is_action_pressed("ui_left") :
		return true
	if Input.is_action_pressed("ui_right") :
		return true
	# If no movement inputs detected return false 
	return false
	
func get_move_animation(direction : Vector2) :
	if direction.y == 1 :
		return "_down"
	elif direction.y == -1 : 
		return "_up"
	elif direction.x == 1 :
		return "_right"
	elif direction.x == -1 :
		return "_left"
	return "_down"
