extends Label

func _process(delta):
	text = "\n" + str(global.current_score)
