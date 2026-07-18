extends CharacterBody2D

const SPEED = 100.0
const RUN_SPEED = 160.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var camera: Camera2D = $Camera2D

signal interact_pressed

var can_interact: bool = false
var nearest_interactable: Node = null

func _ready() -> void:
	var gender = GameManager.hero_gender
	var texture_path = "res://assets/hero_male.svg"
	if gender == "female":
		texture_path = "res://assets/hero_female.svg"
		
	var loaded_texture = load(texture_path)
	if loaded_texture:
		sprite.texture = loaded_texture

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var current_speed = RUN_SPEED if Input.is_key_pressed(KEY_SHIFT) else SPEED
	
	velocity = direction * current_speed
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or (event is InputEventKey and event.pressed and event.keycode == KEY_E):
		if can_interact and nearest_interactable:
			interact_pressed.emit()

func set_interactable(node: Node, active: bool) -> void:
	if active:
		can_interact = true
		nearest_interactable = node
	elif nearest_interactable == node:
		can_interact = false
		nearest_interactable = null

func set_camera_limits(map_width: int, map_height: int) -> void:
	camera.limit_left = 0
	camera.limit_top = 0
	camera.limit_right = map_width
	camera.limit_bottom = map_height
