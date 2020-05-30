extends Sprite

var fade_rate = .05
var alpha_change = .8
	
func _process(delta):
	fade_away()
	
func fade_away():
	alpha_change -= fade_rate
	modulate = Color(1, 1, 1, alpha_change)
	if alpha_change <= 0 :
		queue_free()
  
