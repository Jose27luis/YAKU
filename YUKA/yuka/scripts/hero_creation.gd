extends Control

@onready var name_input: LineEdit = $PanelContainer/MarginContainer/VBoxContainer/NameEdit
@onready var male_panel: PanelContainer = $PanelContainer/MarginContainer/VBoxContainer/GenderContainer/MaleVBox/MalePanel
@onready var male_button: Button = $PanelContainer/MarginContainer/VBoxContainer/GenderContainer/MaleVBox/MaleButton
@onready var female_panel: PanelContainer = $PanelContainer/MarginContainer/VBoxContainer/GenderContainer/FemaleVBox/FemalePanel
@onready var female_button: Button = $PanelContainer/MarginContainer/VBoxContainer/GenderContainer/FemaleVBox/FemaleButton
@onready var start_button: Button = $PanelContainer/MarginContainer/VBoxContainer/StartButton
@onready var back_button: Button = $PanelContainer/MarginContainer/VBoxContainer/BackButton

var selected_gender: String = "male"
var style_selected: StyleBoxFlat
var style_unselected: StyleBoxFlat

func _ready() -> void:
	style_selected = StyleBoxFlat.new()
	style_selected.bg_color = Color(0.16, 0.14, 0.12, 0.5)
	style_selected.border_color = Color(0.85, 0.65, 0.13)
	style_selected.set_border_width_all(2)
	
	style_unselected = StyleBoxFlat.new()
	style_unselected.bg_color = Color(0.16, 0.14, 0.12, 0.5)
	style_unselected.border_color = Color(0.79, 0.64, 0.29, 0.2)
	style_unselected.set_border_width_all(2)

	male_button.pressed.connect(_on_male_selected)
	female_button.pressed.connect(_on_female_selected)
	start_button.pressed.connect(_on_start_pressed)
	back_button.pressed.connect(_on_back_pressed)
	
	male_panel.gui_input.connect(_on_male_panel_input)
	female_panel.gui_input.connect(_on_female_panel_input)
	
	_update_gender_ui()

func _on_male_selected() -> void:
	selected_gender = "male"
	_update_gender_ui()

func _on_female_selected() -> void:
	selected_gender = "female"
	_update_gender_ui()

func _on_male_panel_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		selected_gender = "male"
		_update_gender_ui()

func _on_female_panel_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		selected_gender = "female"
		_update_gender_ui()

func _update_gender_ui() -> void:
	if selected_gender == "male":
		male_button.add_theme_color_override("font_color", Color(0.85, 0.65, 0.13))
		female_button.remove_theme_color_override("font_color")
		male_panel.add_theme_stylebox_override("panel", style_selected)
		female_panel.add_theme_stylebox_override("panel", style_unselected)
	else:
		female_button.add_theme_color_override("font_color", Color(0.85, 0.65, 0.13))
		male_button.remove_theme_color_override("font_color")
		female_panel.add_theme_stylebox_override("panel", style_selected)
		male_panel.add_theme_stylebox_override("panel", style_unselected)

func _on_start_pressed() -> void:
	var name_text = name_input.text.strip_edges()
	if name_text.is_empty():
		name_text = "Viajero"
	
	GameManager.new_game(name_text, selected_gender)
	print("Partida creada: ", GameManager.hero_name, " (", GameManager.hero_gender, ")")
	
	SceneManager.goto_scene("res://scenes/world_map.tscn")

func _on_back_pressed() -> void:
	SceneManager.goto_scene("res://scenes/main_menu.tscn")
