extends Node

var reload_ready = true 

func _ready():
	if global.dev_mode_enabled : 
		global.devTool = self

func _process(delta):
	if Input.is_action_just_pressed("ui_quit"):
		get_tree().quit() 
	if Input.is_action_just_pressed("ui_restart"):
		reload()

		
func reload() :
	var nodes = get_tree().get_root().get_children()
	global.current_score = 0
	for node in nodes : 
		if node.get("permanent") == null :  
			node.queue_free()
	get_tree().reload_current_scene()
