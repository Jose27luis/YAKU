extends Node

signal transition_finished

var transition_layer: CanvasLayer
var fade_rect: ColorRect

func _ready() -> void:
	transition_layer = CanvasLayer.new()
	transition_layer.layer = 128
	
	fade_rect = ColorRect.new()
	fade_rect.color = Color(0, 0, 0, 0)
	fade_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	transition_layer.add_child(fade_rect)
	add_child(transition_layer)

func goto_scene(path: String, duration: float = 0.35) -> void:
	fade_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	
	var tween = create_tween()
	tween.tween_property(fade_rect, "color", Color(0, 0, 0, 1), duration)
	await tween.finished
	
	var error = get_tree().change_scene_to_file(path)
	if error != OK:
		push_error("SceneManager error: " + path)
		fade_rect.color = Color(0, 0, 0, 0)
		fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		return
		
	await get_tree().process_frame
	
	var tween_out = create_tween()
	tween_out.tween_property(fade_rect, "color", Color(0, 0, 0, 0), duration)
	await tween_out.finished
	
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	transition_finished.emit()
