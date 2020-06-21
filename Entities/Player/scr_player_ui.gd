extends Node

onready var health_gui = $HealthUI

export var health_display_time = 1.0
var health_display_timer = Timer.new() 

func _ready() :
	health_display_timer.wait_time = health_display_time
	health_display_timer.one_shot = true
	health_display_timer.connect("timeout", self, "_on_health_display_timeout")
	add_child(health_display_timer)
	health_display_timer.start()

func update_health(health: int) :
	if health - 1 >= 0 : 
		health_gui.frame = health - 1
	else : 
		health_gui.visible = false
		
func _on_health_display_timeout() :
	health_gui.visible = false
	
func _on_Player_player_damaged(health):
	health_gui.visible = true 
	update_health(health) 
	health_display_timer.start()
