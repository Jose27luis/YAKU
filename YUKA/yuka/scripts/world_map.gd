extends Control

@onready var allies_label: Label = $TopBar/MarginContainer/HBoxContainer/AlliesLabel
@onready var seeds_label: Label = $TopBar/MarginContainer/HBoxContainer/SeedsLabel
@onready var back_button: Button = $TopBar/MarginContainer/HBoxContainer/BackButton

@onready var puerto_button: Button = $MapContainer/PuertoButton
@onready var pampa_button: Button = $MapContainer/PampaButton

@onready var zone_name_label: Label = $InfoPanel/MarginContainer/VBoxContainer/ZoneName
@onready var zone_desc_label: Label = $InfoPanel/MarginContainer/VBoxContainer/ZoneDesc
@onready var enter_button: Button = $InfoPanel/MarginContainer/VBoxContainer/EnterButton

var selected_zone: String = "puerto_maldonado"

var zone_data = {
	"puerto_maldonado": {
		"name": "Puerto Maldonado - La Ciudad Gris",
		"desc": "M1 - El regreso.\nVolver al pueblo natal. Aprende a observar los rastros del mercurio y a documentar testimonios iniciales de lo que se perdio."
	},
	"la_pampa": {
		"name": "La Pampa - El Gran Desierto",
		"desc": "M2 - Ver para creer.\nInfiltracion sigilosa en la zona de amortiguamiento de Tambopata. Documenta la devastacion de hectareas y abusos sin ser detectado."
	}
}

func _ready() -> void:
	allies_label.text = "Aliados: " + str(GameManager.allies)
	seeds_label.text = "Semillas: " + str(GameManager.seeds)
	
	back_button.pressed.connect(_on_back_pressed)
	puerto_button.pressed.connect(func(): _select_zone("puerto_maldonado"))
	pampa_button.pressed.connect(func(): _select_zone("la_pampa"))
	enter_button.pressed.connect(_on_enter_pressed)
	
	_select_zone(selected_zone)

func _select_zone(zone_id: String) -> void:
	selected_zone = zone_id
	var data = zone_data[zone_id]
	
	zone_name_label.text = data["name"]
	zone_desc_label.text = data["desc"]
	
	if selected_zone == "puerto_maldonado":
		puerto_button.add_theme_color_override("font_color", Color(0.85, 0.65, 0.13))
		pampa_button.remove_theme_color_override("font_color")
	else:
		pampa_button.add_theme_color_override("font_color", Color(0.85, 0.65, 0.13))
		puerto_button.remove_theme_color_override("font_color")

func _on_enter_pressed() -> void:
	GameManager.selected_zone = selected_zone
	print("Viajando a: ", selected_zone)
	SceneManager.goto_scene("res://scenes/zone.tscn")

func _on_back_pressed() -> void:
	SceneManager.goto_scene("res://scenes/main_menu.tscn")
