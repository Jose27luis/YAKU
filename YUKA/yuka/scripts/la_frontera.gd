extends Node2D

const MAP_WIDTH = 1920
const MAP_HEIGHT = 1080

@onready var hero: CharacterBody2D = $Hero
@onready var zone_label: Label = $UILayer/ZoneLabel
@onready var back_button: Button = $UILayer/BackButton

func _ready() -> void:
	# Configurar límites de cámara del héroe
	hero.set_camera_limits(MAP_WIDTH, MAP_HEIGHT)
	
	# Conectar botón de retorno al mapa
	back_button.pressed.connect(_on_back_pressed)
	
	# Mostrar nombre de la sub-zona con animación de desvanecimiento
	zone_label.text = "LA FRONTERA — El Bosque Herido"
	zone_label.visible = true
	zone_label.modulate.a = 1.0
	
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_property(zone_label, "modulate:a", 0.0, 1.0)
	tween.tween_callback(func(): zone_label.visible = false)

func _on_back_pressed() -> void:
	SceneManager.goto_scene("res://scenes/world_map.tscn")
