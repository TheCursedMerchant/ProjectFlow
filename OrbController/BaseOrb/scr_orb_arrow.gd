extends Sprite

func _ready():
	visible = false 

func _process(delta):
	# Rotate Arrow Towards the Mouse
	var mouse_position = get_local_mouse_position()
	rotation += mouse_position.angle()
	
	
		

	
