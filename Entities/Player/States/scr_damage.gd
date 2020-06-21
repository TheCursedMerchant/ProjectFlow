extends "res://Entities/StateControl/scr_state.gd"

export var damage_time = 0.5
export var knock_back = 10000
var damage_timer = Timer.new()
var blink = true

func _ready():
	damage_timer.wait_time = damage_time
	damage_timer.one_shot = true
	damage_timer.connect("timeout", self, "_on_damage_timeout")
	add_child(damage_timer)

func enter() :
	damage_timer.start()
	target.move_and_slide(-target.damage_direction * knock_back)
	
func process(delta):
	# TODO: Play appropriate animation 
	target.sprite.play("Idle")
	if blink : 
		target.sprite.modulate = Color(10, 10, 10, 10)
	else : 
		target.sprite.modulate = Color(1, 1, 1, 1)
	blink = !blink
	
func exit():
	target.sprite.modulate = Color(1, 1, 1, 1)
	blink = true
	
func _on_damage_timeout() :
	emit_signal("finished", "idle")
	
