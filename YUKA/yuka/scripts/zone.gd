extends Node

func _ready() -> void:
	var zone_id = GameManager.selected_zone
	
	match zone_id:
		"la_pampa":
			get_tree().change_scene_to_file("res://scenes/la_frontera.tscn")
		"puerto_maldonado":
			get_tree().change_scene_to_file("res://scenes/la_frontera.tscn")
		_:
			push_error("Zone: zona desconocida - " + zone_id)
			get_tree().change_scene_to_file("res://scenes/world_map.tscn")
