extends Control

@onready var new_game_button: Button = $PanelContainer/MarginContainer/VBoxContainer/NewGameButton
@onready var continue_button: Button = $PanelContainer/MarginContainer/VBoxContainer/ContinueButton
@onready var quit_button: Button = $PanelContainer/MarginContainer/VBoxContainer/QuitButton

func _ready() -> void:
	new_game_button.pressed.connect(_on_new_game_pressed)
	continue_button.pressed.connect(_on_continue_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	continue_button.disabled = false

func _on_new_game_pressed() -> void:
	SceneManager.goto_scene("res://scenes/hero_creation.tscn")

func _on_continue_pressed() -> void:
	GameManager.new_game("Raiz", "male")
	print("Cargando partida guardada (Raiz)...")
	SceneManager.goto_scene("res://scenes/world_map.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
