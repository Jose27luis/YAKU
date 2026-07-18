extends TileMap

const CHUNK_SIZE = 16
const TILE_SIZE = 32
const RENDER_DISTANCE = 3

@export var player: CharacterBody2D

var noise: FastNoiseLite
var loaded_chunks = {}
var source_id = 0
var last_player_chunk = Vector2i(-999, -999)

var safe_points = [
	Vector2(120, 450),
	Vector2(440, 420),
	Vector2(1350, 500),
	Vector2(500, 550),
	Vector2(750, 950),
	Vector2(1600, 350)
]

func _ready() -> void:
	texture_filter = TEXTURE_FILTER_NEAREST
	_init_tileset()
	
	noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.seed = 42
	noise.frequency = 0.05
	
	if not player:
		player = get_parent().get_node_or_null("Hero")
		
	if player:
		_update_chunks()

func _process(_delta: float) -> void:
	if not player:
		return
		
	var px = floor(player.global_position.x / (CHUNK_SIZE * TILE_SIZE))
	var py = floor(player.global_position.y / (CHUNK_SIZE * TILE_SIZE))
	var current_chunk = Vector2i(px, py)
	
	if current_chunk != last_player_chunk:
		last_player_chunk = current_chunk
		_update_chunks()

func _init_tileset() -> void:
	var img = Image.create(64, 64, false, Image.FORMAT_RGBA8)
	img.fill_rect(Rect2i(0, 0, 32, 32), Color("#1d2b12"))
	img.fill_rect(Rect2i(32, 0, 32, 32), Color("#42321e"))
	img.fill_rect(Rect2i(0, 32, 32, 32), Color("#354f2c"))
	img.fill_rect(Rect2i(32, 32, 32, 32), Color("#0a0f07"))
	
	var tex = ImageTexture.create_from_image(img)
	
	var new_tileset = TileSet.new()
	new_tileset.tile_size = Vector2i(TILE_SIZE, TILE_SIZE)
	new_tileset.add_physics_layer()
	
	var atlas_source = TileSetAtlasSource.new()
	atlas_source.texture = tex
	atlas_source.texture_region_size = Vector2i(TILE_SIZE, TILE_SIZE)
	
	atlas_source.create_tile(Vector2i(0, 0))
	atlas_source.create_tile(Vector2i(1, 0))
	atlas_source.create_tile(Vector2i(0, 1))
	atlas_source.create_tile(Vector2i(1, 1))
	
	var tile_data = atlas_source.get_tile_data(Vector2i(1, 1), 0)
	if tile_data:
		var points = PackedVector2Array([
			Vector2(-16, -16),
			Vector2(16, -16),
			Vector2(16, 16),
			Vector2(-16, 16)
		])
		tile_data.add_collision_polygon(0)
		tile_data.set_collision_polygon_points(0, 0, points)
		
	new_tileset.add_source(atlas_source, source_id)
	self.tile_set = new_tileset

func _update_chunks() -> void:
	var active_chunks = {}
	
	for x in range(last_player_chunk.x - RENDER_DISTANCE, last_player_chunk.x + RENDER_DISTANCE + 1):
		for y in range(last_player_chunk.y - RENDER_DISTANCE, last_player_chunk.y + RENDER_DISTANCE + 1):
			var chunk_coords = Vector2i(x, y)
			active_chunks[chunk_coords] = true
			
			if not loaded_chunks.has(chunk_coords):
				_load_chunk(chunk_coords)
				
	var loaded_keys = loaded_chunks.keys()
	for key in loaded_keys:
		if not active_chunks.has(key):
			_unload_chunk(key)

func _load_chunk(chunk_coords: Vector2i) -> void:
	for x in range(CHUNK_SIZE):
		for y in range(CHUNK_SIZE):
			var gx = chunk_coords.x * CHUNK_SIZE + x
			var gy = chunk_coords.y * CHUNK_SIZE + y
			
			var pixel_pos = Vector2(gx * TILE_SIZE + 16, gy * TILE_SIZE + 16)
			var is_safe = false
			for sp in safe_points:
				if pixel_pos.distance_to(sp) < 60.0:
					is_safe = true
					break
			
			var atlas_coord = Vector2i(0, 0)
			if is_safe:
				atlas_coord = Vector2i(1, 0)
			else:
				var n = noise.get_noise_2d(gx, gy)
				if n < -0.15:
					atlas_coord = Vector2i(0, 0)
				elif n >= -0.15 and n < 0.15:
					atlas_coord = Vector2i(1, 0)
				elif n >= 0.15 and n < 0.35:
					atlas_coord = Vector2i(0, 1)
				else:
					atlas_coord = Vector2i(1, 1)
				
			set_cell(0, Vector2i(gx, gy), source_id, atlas_coord)
			
	loaded_chunks[chunk_coords] = true

func _unload_chunk(chunk_coords: Vector2i) -> void:
	for x in range(CHUNK_SIZE):
		for y in range(CHUNK_SIZE):
			var gx = chunk_coords.x * CHUNK_SIZE + x
			var gy = chunk_coords.y * CHUNK_SIZE + y
			set_cell(0, Vector2i(gx, gy), -1)
			
	loaded_chunks.erase(chunk_coords)
