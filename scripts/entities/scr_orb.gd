extends Area2D

export var move_speed = 50
export var knockback_speed = 10 
export var base_follow_percent = .2
export var recover_follow_percent = .05
export var damage = 10
export var power_rate = 5
export var max_power = 100
var move_vector = Vector2() 
var can_shoot = true
var move_direction = Vector2()
var current_power = 0
onready var shoot_timer = $ShootTimer
onready var recover_timer = $RecoverTimer
onready var gui_arrow = $Arrow_GUI
onready var trail = $Trail

enum STATES {IDLE, SHOOT, CHARGE, KNOCKBACK, RECOVER}
var current_state = STATES.IDLE

signal orb_impact

func _process(delta):
	# Rotate Arrow Towards the Mouse
	var mouse_position = get_local_mouse_position()
	rotation += mouse_position.angle()

func _physics_process(delta):
	match (current_state): 
		STATES.IDLE:
			idle()
		STATES.CHARGE:
			charge()
		STATES.SHOOT:
			shoot()
		STATES.KNOCKBACK:
			knockback()
		STATES.RECOVER:
			recover()

func shoot(): 
	# Shoot orb
	global_position += move_direction * move_speed
	trail.emitting = true
	
func charge():
	if current_power < max_power :
		current_power += power_rate
	else:
		current_power = max_power
		
	if Input.is_action_just_released("ui_shoot"):
		shoot_timer.start()
		can_shoot = false
		move_direction = global_position.direction_to( get_global_mouse_position() )
		gui_arrow.visible = false
		current_state = STATES.SHOOT


func follow(follow_percent):
	position.x += (get_global_mouse_position().x - global_position.x) * follow_percent
	position.y += (get_global_mouse_position().y - global_position.y) * follow_percent

func knockback():
	global_position += -move_direction * knockback_speed

func _on_Timer_timeout():
	can_shoot = true
	trail.emitting = false
	current_power = 0
	if current_state == STATES.KNOCKBACK :
		recover_timer.start()
		current_state = STATES.RECOVER
	else :
		current_state = STATES.IDLE
		
func idle() :
	follow(base_follow_percent)
	if Input.is_action_pressed("ui_shoot") && can_shoot:
		current_state = STATES.CHARGE
		gui_arrow.visible = true 

func _on_Orb_area_entered(area):
	if (area.is_in_group("Enemy") && current_state == STATES.SHOOT) :
		emit_signal("orb_impact", current_power)
		area.get_parent().take_damage(damage * current_power / 10)
		shoot_timer.start()
		current_state = STATES.KNOCKBACK
	elif (area.is_in_group("Orb") ) :
		queue_free()

func recover():
	follow(recover_follow_percent)
	global_position += -move_direction * ( knockback_speed / 3 )
	
func _on_RecoverTimer_timeout():
	current_state = STATES.IDLE
