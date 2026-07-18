extends Control

@onready var new_game_button: Button = $PanelContainer/MarginContainer/VBoxContainer/NewGameButton
@onready var continue_button: Button = $PanelContainer/MarginContainer/VBoxContainer/ContinueButton
@onready var quit_button: Button = $PanelContainer/MarginContainer/VBoxContainer/QuitButton

func _ready() -> void:
	new_game_button.pressed.connect(_on_new_game_pressed)
	continue_button.pressed.connect(_on_continue_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	# Por ahora, habilitar continuar siempre (para pruebas)
	continue_button.disabled = false

func _on_new_game_pressed() -> void:
	SceneManager.goto_scene("res://scenes/hero_creation.tscn")

func _on_continue_pressed() -> void:
	# Simula cargar partida guardada según el GDD
	GameManager.new_game("Raíz", "male")
	# En una etapa posterior, esto cargaría el mapa del mundo
	# SceneManager.goto_scene("res://scenes/world_map.tscn")
	print("Cargando partida guardada (Raíz)...")

func _on_quit_pressed() -> void:
	get_tree().quit()
