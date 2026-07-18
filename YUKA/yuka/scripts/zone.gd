extends Node

# Este script actúa como un redireccionador.
# Cuando se carga zone.tscn, inmediatamente redirige
# a la sub-zona correcta según la selección del GameManager.

func _ready() -> void:
	var zone_id = GameManager.selected_zone
	
	match zone_id:
		"la_pampa":
			# Cargar la primera sub-zona de La Pampa
			get_tree().change_scene_to_file("res://scenes/la_frontera.tscn")
		"puerto_maldonado":
			# Placeholder: por ahora redirige a la_frontera también
			# En el futuro tendrá su propia escena
			get_tree().change_scene_to_file("res://scenes/la_frontera.tscn")
		_:
			push_error("Zone: zona desconocida — " + zone_id)
			get_tree().change_scene_to_file("res://scenes/world_map.tscn")
