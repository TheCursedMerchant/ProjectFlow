extends "res://Entities/Player/States/scr_movement.gd"

func enter() :
	animation_sprite = "idle" + get_move_animation(target.move_direction)

func process(delta):
	target.sprite.play(animation_sprite)

func update(delta):
	if get_move_input() : 
		emit_signal("finished", "move")
		return
	if Input.is_action_just_pressed("ui_dash") && target.can_dash:
		emit_signal("finished", "dash")
	
