extends Node

signal lives_changed(new_lives: int)
signal vinculo_changed(new_vinculo: int)
signal evidence_added(item: Dictionary)
signal testimonio_added(dialogue_id: String)
signal allies_changed(new_allies: int)
signal seeds_changed(new_seeds: int)

var hero_name: String = "Viajero"
var hero_gender: String = "male"

var lives: int = 3: set = set_lives
var vinculo: int = 4: set = set_vinculo
var seeds: int = 2: set = set_seeds
var allies: int = 0: set = set_allies

var evidence: Array = []
var testimonies: Array = []
var selected_zone: String = "puerto_maldonado"

func set_lives(val: int) -> void:
	lives = clamp(val, 0, 3)
	lives_changed.emit(lives)

func set_vinculo(val: int) -> void:
	vinculo = clamp(val, 0, 5)
	vinculo_changed.emit(vinculo)

func set_seeds(val: int) -> void:
	seeds = clamp(val, 0, 99)
	seeds_changed.emit(seeds)

func set_allies(val: int) -> void:
	allies = max(0, val)
	allies_changed.emit(allies)

func new_game(name_input: String, gender_input: String) -> void:
	hero_name = name_input.strip_edges()
	if hero_name.is_empty():
		hero_name = "Viajero"
	hero_gender = gender_input
	
	lives = 3
	vinculo = 4
	seeds = 2
	allies = 0
	evidence.clear()
	testimonies.clear()
	selected_zone = "puerto_maldonado"

func add_evidence(item_name: String, zone: String) -> void:
	var item = {
		"id": Time.get_unix_time_from_system(),
		"name": item_name,
		"zone": zone
	}
	evidence.append(item)
	evidence_added.emit(item)

func add_testimonio(dialogue_id: String) -> void:
	if not testimonies.has(dialogue_id):
		testimonies.append(dialogue_id)
		testimonio_added.emit(dialogue_id)
