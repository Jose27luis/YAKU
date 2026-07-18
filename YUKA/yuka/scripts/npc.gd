extends Area2D

# Propiedades configurables del NPC desde el Inspector de Godot
@export var npc_name: String = "Desconocido"
@export var npc_role: String = "Habitante"
@export var dialogue_lines: Array[String] = []
@export var dialogue_id: String = "" # ID único para registrar testimonio
@export var npc_color: Color = Color(0.69, 0.49, 0.23) # Color del sprite placeholder

@onready var sprite: Sprite2D = $Sprite2D
@onready var interact_label: Label = $InteractLabel

var hero_ref: CharacterBody2D = null
var is_hero_near: bool = false

func _ready() -> void:
	# Configurar color del sprite placeholder
	sprite.modulate = npc_color
	
	# Ocultar indicador de interacción
	interact_label.visible = false
	
	# Conectar señales de detección de área
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.has_signal("interact_pressed"):
		hero_ref = body
		is_hero_near = true
		interact_label.visible = true
		hero_ref.set_interactable(self, true)
		# Conectar señal de interacción
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
	if not is_hero_near:
		return
	# Disparar el sistema de diálogo
	var dialogue_box = get_tree().get_first_node_in_group("dialogue_box")
	if dialogue_box:
		dialogue_box.start_dialogue(npc_name, npc_role, dialogue_lines, dialogue_id)
