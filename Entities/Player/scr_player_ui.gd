extends Node

onready var health_gui = $HealthUI
onready var dash_bar = $DashCooldownBar

export var health_display_time = 1.0
export var dash_cooldown_display_time = 0.05
var health_display_timer = Timer.new() 
var dash_bar_timer = Timer.new() 

func _ready() :
	health_display_timer.wait_time = health_display_time
	health_display_timer.one_shot = true
	health_display_timer.connect("timeout", self, "_on_health_display_timeout")
	add_child(health_display_timer)
	
	dash_bar_timer.wait_time = dash_cooldown_display_time
	dash_bar_timer.one_shot = true
	dash_bar_timer.connect("timeout", self, "_on_dash_display_timeout")
	add_child(dash_bar_timer)
	
	health_display_timer.start()
	dash_bar_timer.start()

func update_health(health: int) :
	if health - 1 >= 0 : 
		health_gui.frame = health - 1
	else : 
		health_gui.visible = false
		
func update_dash_bar(value): 
	dash_bar.visible = true
	dash_bar_timer.start()
	dash_bar.value = value
		
func _on_health_display_timeout() :
	health_gui.visible = false
	
func _on_dash_display_timeout():
	dash_bar.visible = false
	
func _on_Player_player_damaged(health):
	health_gui.visible = true 
	update_health(health) 
	health_display_timer.start()
