extends Node2D

export (PackedScene) var scn_spawn_item;
onready var sprite = $Sprite
var can_spawn = true

signal spawn_updated

func _ready():
	connect("spawn_updated", get_parent(), "_on_spawn_updated")

func spawn():
	if(can_spawn) :
		
		sprite.frame = 0
		sprite.play("default")
		
		if get_parent().get("spawn_count") != null : 
			get_parent().spawn_count += 1 
		
		can_spawn = false
		var spawn_item = scn_spawn_item.instance(0)
		spawn_item.global_position = global_position
		spawn_item.spawner = self
		spawn_item.connect("entity_died", self, "_on_spawn_item_died")
		get_tree().get_root().add_child(spawn_item)
	
func _on_spawn_item_died() :
	get_parent().spawn_count -= 1
	can_spawn = true
	emit_signal("spawn_updated")

