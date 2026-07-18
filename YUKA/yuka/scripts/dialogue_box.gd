extends CanvasLayer

@onready var panel: PanelContainer = $DialoguePanel
@onready var name_label: Label = $DialoguePanel/MarginContainer/VBoxContainer/HBoxHeader/NameLabel
@onready var role_label: Label = $DialoguePanel/MarginContainer/VBoxContainer/HBoxHeader/RoleLabel
@onready var text_label: Label = $DialoguePanel/MarginContainer/VBoxContainer/TextLabel
@onready var advance_label: Label = $DialoguePanel/MarginContainer/VBoxContainer/AdvanceLabel

var current_lines: Array = []
var current_step: int = 0
var current_dialogue_id: String = ""
var is_active: bool = false

signal dialogue_finished(dialogue_id: String)

func _ready() -> void:
	add_to_group("dialogue_box")
	panel.visible = false

func start_dialogue(speaker_name: String, speaker_role: String, lines: Array, dialogue_id: String = "") -> void:
	if lines.is_empty():
		return
	
	current_lines = lines
	current_step = 0
	current_dialogue_id = dialogue_id
	is_active = true
	
	name_label.text = speaker_name.to_upper()
	role_label.text = speaker_role
	text_label.text = current_lines[0]
	
	panel.visible = true

func _unhandled_input(event: InputEvent) -> void:
	if not is_active:
		return
	
	if event.is_action_pressed("ui_accept") or (event is InputEventKey and event.pressed and event.keycode == KEY_E):
		_advance()
		get_viewport().set_input_as_handled()

func _advance() -> void:
	current_step += 1
	
	if current_step >= current_lines.size():
		_end_dialogue()
	else:
		text_label.text = current_lines[current_step]

func _end_dialogue() -> void:
	is_active = false
	panel.visible = false
	
	if not current_dialogue_id.is_empty():
		GameManager.add_testimonio(current_dialogue_id)
	
	dialogue_finished.emit(current_dialogue_id)
