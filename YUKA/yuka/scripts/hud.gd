extends CanvasLayer

@onready var name_label: Label = $TopBar/MarginContainer/HBoxContainer/VBoxName/NameLabel
@onready var lives_label: Label = $TopBar/MarginContainer/HBoxContainer/VBoxStats/LivesLabel
@onready var vinculo_label: Label = $TopBar/MarginContainer/HBoxContainer/VBoxStats/VinculoLabel
@onready var evidence_label: Label = $TopBar/MarginContainer/HBoxContainer/VBoxStats/EvidenceLabel

func _ready() -> void:
	# Cargar datos iniciales
	name_label.text = GameManager.hero_name.to_upper()
	_update_lives(GameManager.lives)
	_update_vinculo(GameManager.vinculo)
	_update_evidence_count(GameManager.evidence.size())
	
	# Conectar señales del GameManager
	GameManager.lives_changed.connect(_update_lives)
	GameManager.vinculo_changed.connect(_update_vinculo)
	GameManager.evidence_added.connect(func(_item): _update_evidence_count(GameManager.evidence.size()))

func _update_lives(lives: int) -> void:
	# 🍁 representativas de hojas activas, 🍂 marchitas
	var active_leaves = ""
	for i in range(3):
		if i < lives:
			active_leaves += "🍁"
		else:
			active_leaves += "🍂"
	lives_label.text = "SALUD: " + active_leaves

func _update_vinculo(vinculo: int) -> void:
	# Representación segmentada del vínculo en 5 niveles [■■■■□]
	var active_segments = ""
	for i in range(5):
		if i < vinculo:
			active_segments += "■"
		else:
			active_segments += "□"
	vinculo_label.text = "VÍNCULO: [" + active_segments + "]"

func _update_evidence_count(count: int) -> void:
	evidence_label.text = "EVIDENCIAS: " + str(count) + "/5"
