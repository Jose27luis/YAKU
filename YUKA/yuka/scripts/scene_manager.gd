extends Node

# Señal emitida cuando la transición termina
signal transition_finished

# Elementos dinámicos para el fundido
var transition_layer: CanvasLayer
var fade_rect: ColorRect

func _ready() -> void:
	# Crear el overlay de CanvasLayer dinámicamente para que no requiera un archivo .tscn
	transition_layer = CanvasLayer.new()
	transition_layer.layer = 128 # Capa alta para pintar sobre todo lo demás
	
	fade_rect = ColorRect.new()
	fade_rect.color = Color(0, 0, 0, 0) # Inicialmente transparente
	fade_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	transition_layer.add_child(fade_rect)
	add_child(transition_layer)

# Cambiar de escena con efecto de fundido
func goto_scene(path: String, duration: float = 0.35) -> void:
	# Detener inputs durante la transición
	fade_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	
	# Fundido a negro (Fade-In)
	var tween = create_tween()
	tween.tween_property(fade_rect, "color", Color(0, 0, 0, 1), duration)
	await tween.finished
	
	# Cargar nueva escena
	var error = get_tree().change_scene_to_file(path)
	if error != OK:
		push_error("SceneManager: Error al cambiar de escena a: " + path)
		fade_rect.color = Color(0, 0, 0, 0)
		fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		return
		
	# Esperar un frame a que se monte la nueva escena
	await get_tree().process_frame
	
	# Fundido de salida (Fade-Out)
	var tween_out = create_tween()
	tween_out.tween_property(fade_rect, "color", Color(0, 0, 0, 0), duration)
	await tween_out.finished
	
	# Habilitar inputs de nuevo
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	transition_finished.emit()
