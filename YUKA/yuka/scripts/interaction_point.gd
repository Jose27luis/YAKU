extends Area2D

# Propiedades configurables desde el Inspector de Godot
@export var point_name: String = "Punto de interés"
@export var evidence_name: String = "Evidencia documentada"
@export var evidence_zone: String = "La Frontera"

@onready var interact_label: Label = $InteractLabel
@onready var sprite: Sprite2D = $Sprite2D

var hero_ref: CharacterBody2D = null
var is_hero_near: bool = false
var is_collected: bool = false

func _ready() -> void:
	interact_label.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if is_collected:
		return
	if body is CharacterBody2D and body.has_signal("interact_pressed"):
		hero_ref = body
		is_hero_near = true
		interact_label.visible = true
		hero_ref.set_interactable(self, true)
		if not hero_ref.interact_pressed.is_connected(_on_interact):
			hero_ref.interact_pressed.connect(_on_interact)

func _on_body_exited(body: Node2D) -> void:
	if body == hero_ref:
		is_hero_near = false
		interact_label.visible = false
		hero_ref.set_interactable(self, false)
		if hero_ref.interact_pressed.is_connected(_on_interact):
			hero_ref.interact_pressed.disconnect(_on_interact)
		hero_ref = null

func _on_interact() -> void:
	if not is_hero_near or is_collected:
		return
	
	is_collected = true
	interact_label.visible = false
	
	# Registrar evidencia en el GameManager
	GameManager.add_evidence(evidence_name, evidence_zone)
	
	# Efecto visual: flash blanco + cambiar opacidad del sprite
	var flash = ColorRect.new()
	flash.color = Color(1, 1, 1, 0.6)
	flash.set_anchors_preset(Control.PRESET_FULL_RECT)
	flash.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	# Añadir flash al viewport global para simular foto de cámara
	get_tree().root.add_child(flash)
	
	var tween = create_tween()
	tween.tween_property(flash, "color:a", 0.0, 0.4)
	tween.tween_callback(flash.queue_free)
	
	# Atenuar el sprite del punto de interés para indicar recolección
	sprite.modulate.a = 0.3
	
	# Desconectar al héroe
	if hero_ref:
		hero_ref.set_interactable(self, false)
