extends "res://scripts/entities/scr_entity.gd"

var scn_orb = preload("res://scenes/entities/Orb.tscn")
var scn_main_camera = preload("res://scenes/engine/scn_MainCamera.tscn")
var current_orb
onready var dash_timer = $DashTimer
onready var dash_cooldown = $DashCoolDown
onready var trail = $Trail
onready var anim_player = $AnimationPlayer
onready var dash_hit_timer = $DashHitTimer
var can_dash = true
var is_dash = false
var fade_maker
var dash_hit = false
var dash_count = 0.0
export var fade_amount = 5
var move_direction = Vector2()
export var dash_speed = 700
export var dash_damage = 100

# Dash Stuff
onready var dash_ray_one = $DashRay_01
onready var dash_ray_two = $DashRay_02
var dash_distance = 200

signal player_shake;

func _ready():
	fade_maker = $FadeMaker
	
	# Add Equipment Orb
	current_orb = scn_orb.instance(0)
	current_orb.connect("orb_impact", self, "_on_orb_impact")
	current_orb.global_position = global_position
	global.player_orb = weakref(current_orb)
	get_tree().get_root().call_deferred("add_child", current_orb)

	# Add Main Camera
	var camera = scn_main_camera.instance(0)
	self.connect("player_shake", camera, "_on_Player_player_shake")
	camera.player = weakref(self)
	get_tree().get_root().call_deferred("add_child", camera)

func _physics_process(delta):

	if dash_count > 0 : 
		if ( Input.is_action_just_pressed("ui_dash") && (dash_timer.time_left <= dash_timer.get_wait_time() * (1 / dash_count) ) ): 
			dash()
	if is_dash :
		move_vector += move_direction * dash_speed
	else:
		move_vector = Vector2(0, 0)
		collision_mask = 1
	
	# Check for input
	if (!is_dash): 
		if Input.is_action_pressed("ui_up"):
			move_vector.y = -move_speed;
			move_direction = move_vector.normalized()
		if Input.is_action_pressed("ui_down"):
			move_vector.y = move_speed; 
			move_direction = move_vector.normalized()
		if Input.is_action_pressed("ui_left"):
			move_vector.x = -move_speed;
			move_direction = move_vector.normalized() 
		if Input.is_action_pressed("ui_right"):
			move_vector.x = move_speed;
			move_direction = move_vector.normalized() 
			
	if Input.is_action_just_pressed("ui_dash") && can_dash:
		dash() 
	
	move_and_slide(move_vector)
	
func dash():
	dash_count += 1
	dash_hit = true
#	anim_player.play("Dash")
	# Make player dash 
	can_dash = false
	is_dash = true
	dash_timer.start()
	dash_cooldown.start()
	collision_mask = 2

# Duration of the Dash has ended 
func _on_DashTimer_timeout():
	is_dash = false
	dash_hit_timer.start()

# Dash Hit Window closed 
func _on_DashHitTimer_timeout():
	dash_count = 0
	dash_hit = false

# Player can Dash Again
func _on_DashCoolDown_timeout():
	can_dash = true
		
func _on_orb_impact(force):
	emit_signal("player_shake", 0.35, 20 * force, 20)
