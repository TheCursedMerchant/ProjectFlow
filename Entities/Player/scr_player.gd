extends "res://Entities/scr_entity.gd"

# Dependent Scenes 
var scn_orb = preload("res://OrbController/BaseOrb/Orb.tscn")
var scn_main_camera = preload("res://Engine/Camera/scn_MainCamera.tscn")
var current_orb

# Children References 
onready var dash_timer = $DashTimer
onready var dash_cooldown = $DashCoolDown
onready var trail = $Trail
onready var dash_hit_timer = $DashHitTimer
onready var sprite = $Sprite
onready var damage_timer = $DamageTimer

# TODO: Remove while not used
onready var state_machine = $StateMachine

# Player Config
export var fade_amount = 5
export var dash_speed = 750
export var dash_damage = 100

# State Properties 
var can_dash = true
var dash_hit = false
var dash_count = 0
var move_direction = Vector2(1, 0)
var move_sprite_name = "_down"
var damage_direction = Vector2()

# Signals 
signal player_shake;
signal player_damaged;

func _process(delta) :
	if Input.is_action_just_pressed("ui_accept") :
		take_damage(1, Vector2(-1, 0)) 

func _ready():
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
	
# Dash Hit Window closed 
func _on_DashHitTimer_timeout():
	dash_count = 0
	dash_hit = false

# Player can Dash Again
func _on_DashCoolDown_timeout():
	can_dash = true

# Shake Camera on Orb impact
func _on_orb_impact(force):
	emit_signal("player_shake", 0.35, 20 * force, 20)
	
func take_damage(damage, direction) :
	damage_direction = direction
	health_points -= damage
	emit_signal("player_damaged")
	emit_signal("player_shake", .35 , 20, 20)
	state_machine.current_state.emit_signal("finished", "damage") 

