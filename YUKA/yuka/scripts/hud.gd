extends CanvasLayer

@onready var name_label: Label = $TopBar/MarginContainer/HBoxContainer/VBoxName/NameLabel
@onready var lives_label: Label = $TopBar/MarginContainer/HBoxContainer/VBoxStats/LivesLabel
@onready var vinculo_label: Label = $TopBar/MarginContainer/HBoxContainer/VBoxStats/VinculoLabel
@onready var evidence_label: Label = $TopBar/MarginContainer/HBoxContainer/VBoxStats/EvidenceLabel

func _ready() -> void:
	name_label.text = GameManager.hero_name.to_upper()
	_update_lives(GameManager.lives)
	_update_vinculo(GameManager.vinculo)
	_update_evidence_count(GameManager.evidence.size())
	
	GameManager.lives_changed.connect(_update_lives)
	GameManager.vinculo_changed.connect(_update_vinculo)
	GameManager.evidence_added.connect(func(_item): _update_evidence_count(GameManager.evidence.size()))

func _update_lives(lives: int) -> void:
	var active_lives = ""
	for i in range(3):
		if i < lives:
			active_lives += "*"
		else:
			active_lives += "."
	lives_label.text = "SALUD: " + active_lives

func _update_vinculo(vinculo: int) -> void:
	var active_segments = ""
	for i in range(5):
		if i < vinculo:
			active_segments += "#"
		else:
			active_segments += "."
	vinculo_label.text = "VINCULO: [" + active_segments + "]"

func _update_evidence_count(count: int) -> void:
	evidence_label.text = "EVIDENCIAS: " + str(count) + "/5"
