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

# Datos narrativos de las zonas
var zone_data = {
	"puerto_maldonado": {
		"name": "Puerto Maldonado — La Ciudad Gris",
		"desc": "M1 · El regreso.\nVolver al pueblo natal. Aprende a observar los rastros del mercurio y a documentar testimonios iniciales de lo que se perdió."
	},
	"la_pampa": {
		"name": "La Pampa — El Gran Desierto",
		"desc": "M2 · Ver para creer.\nInfiltración sigilosa en la zona de amortiguamiento de Tambopata. Documenta la devastación de hectáreas y abusos sin ser detectado."
	}
}

func _ready() -> void:
	# Cargar estadísticas iniciales de GameManager
	allies_label.text = "Aliados: " + str(GameManager.allies)
	seeds_label.text = "🌱 ×" + str(GameManager.seeds)
	
	# Conectar señales
	back_button.pressed.connect(_on_back_pressed)
	puerto_button.pressed.connect(func(): _select_zone("puerto_maldonado"))
	pampa_button.pressed.connect(func(): _select_zone("la_pampa"))
	enter_button.pressed.connect(_on_enter_pressed)
	
	# Seleccionar zona por defecto
	_select_zone(selected_zone)

func _select_zone(zone_id: String) -> void:
	selected_zone = zone_id
	var data = zone_data[zone_id]
	
	# Actualizar textos
	zone_name_label.text = data["name"]
	zone_desc_label.text = data["desc"]
	
	# Destacar visualmente el botón seleccionado mediante colores
	if selected_zone == "puerto_maldonado":
		puerto_button.add_theme_color_override("font_color", Color(0.85, 0.65, 0.13)) # Oro
		pampa_button.remove_theme_color_override("font_color")
	else:
		pampa_button.add_theme_color_override("font_color", Color(0.85, 0.65, 0.13)) # Oro
		puerto_button.remove_theme_color_override("font_color")

func _on_enter_pressed() -> void:
	GameManager.selected_zone = selected_zone
	print("Viajando a: ", selected_zone)
	# Transicionar a la escena del nivel (zona)
	SceneManager.goto_scene("res://scenes/zone.tscn")

func _on_back_pressed() -> void:
	# Regresar al Menú Principal
	SceneManager.goto_scene("res://scenes/main_menu.tscn")
