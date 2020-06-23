extends "res://Entities/Player/States/scr_movement.gd"

var dash_timer = Timer.new()
var dash_count = 0

func handle_input(event) :
	if get_move_input() :
		target.move_vector = get_input_direction()
	
	if event.is_action_pressed("ui_dash") && dash_refresh():
		emit_signal("finished", "dash")
		
func _ready() :
	dash_timer.one_shot = true
	dash_timer.set_wait_time(0.2)
	dash_timer.connect("timeout", self, "on_dash_timeout")
	add_child(dash_timer)

func enter() :
	dash_timer.start()
	dash_count += 1
	target.trail.emitting = true
	target.move_vector = Vector2()
	target.dash_hit = true
	target.can_dash = false
	target.dash_progress = 0
	target.dash_cooldown.start()
	target.collision_mask = 2
	
func update(delta):
	target.move_vector = target.move_direction * target.dash_speed
	target.move_vector = target.move_and_slide(target.move_vector)

func exit() :
	target.trail.emitting = false
	target.collision_mask = 1
	
func on_dash_timeout() :
	dash_count = 0
	target.dash_hit_timer.start()
	emit_signal("finished", "idle")
	
func dash_refresh() :
	if dash_count == 0 :
		return false
	return ( dash_timer.time_left <= dash_timer.get_wait_time() )  #* (1 / dash_count)

