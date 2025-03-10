extends Node2D


const SOURCE_ID = 1


@onready var tile_layers: Node2D = $TileLayers
@onready var floor_tiles: TileMapLayer = $TileLayers/Floor
@onready var wall_tiles: TileMapLayer = $TileLayers/Wall
@onready var targets_tiles: TileMapLayer = $TileLayers/Targets
@onready var boxes_tiles: TileMapLayer = $TileLayers/Boxes
@onready var player: AnimatedSprite2D = $Player
@onready var camera_2d: Camera2D = $Camera2D
@onready var hud: Hud = $CanvasLayer2/Hud
@onready var game_over_ui: GameOverUI = $CanvasLayer2/GameOverUI


var _total_moves: int = 0
var _player_tile: Vector2i = Vector2i.ZERO
var _game_over: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reload"):
		setup_level()
	if Input.is_action_just_pressed("exit"):
		GameManager.load_main_scene()
	
	if _game_over:
		return
	
	var md: Vector2i = Vector2i.ZERO
	if Input.is_action_just_pressed("right"):
		md = Vector2i.RIGHT
		player.flip_h = false
	elif Input.is_action_just_pressed("left"):
		md = Vector2i.LEFT
		player.flip_h = true
	elif Input.is_action_just_pressed("up"):
		md = Vector2i.UP
	elif Input.is_action_just_pressed("down"):
		md = Vector2i.DOWN
		
	if md != Vector2i.ZERO:
		player_move(md)


func check_game_state() -> void:
	for t in targets_tiles.get_used_cells():
		if cell_is_box(t) == false:
			return
	_game_over = true
	game_over_ui.game_over(GameManager.get_level_selected(), _total_moves)
	ScoreSync.level_completed(GameManager.get_level_selected(), _total_moves)


func place_player_on_tile(tile_coord: Vector2i) -> void:
	var np: Vector2 = Vector2(
		tile_coord.x * LevelData.TILE_SIZE,
		tile_coord.y * LevelData.TILE_SIZE,
	) + tile_layers.position
	player.position = np
	_player_tile = tile_coord


func player_move(direction: Vector2i) -> void:
	var new_tile: Vector2i = _player_tile + direction
	var can_move: bool = true
	var box_seen: bool = false

	if cell_is_wall(new_tile):
		can_move = false

	if cell_is_box(new_tile):
		box_seen = true
		can_move = box_can_move(new_tile, direction)

	if can_move:
		_total_moves += 1
		hud.set_moves_label(_total_moves)
		if box_seen:
			move_box(new_tile, direction)
		place_player_on_tile(new_tile)
		check_game_state()


func cell_is_wall(cell: Vector2i) -> bool:
	return cell in wall_tiles.get_used_cells()


func cell_is_box(cell: Vector2i) -> bool:
	return cell in boxes_tiles.get_used_cells()


func cell_is_empty(cell: Vector2i) -> bool:
	return !cell_is_box(cell) and !cell_is_wall(cell)


func box_can_move(box_tile: Vector2i, direction: Vector2i) -> bool:
	return cell_is_empty(box_tile + direction)


func move_box(box_tile: Vector2i, direction: Vector2i) -> void:
	var dest: Vector2i = box_tile + direction
	boxes_tiles.erase_cell(box_tile)
	if dest in targets_tiles.get_used_cells():
		boxes_tiles.set_cell(
			dest,
			SOURCE_ID,
			get_atlas_coord_for_layer_type(TileLayers.LayerType.TARGET_BOX)
			)
	else:
		boxes_tiles.set_cell(
			dest,
			SOURCE_ID,
			get_atlas_coord_for_layer_type(TileLayers.LayerType.BOX)
			)

func get_atlas_coord_for_layer_type(lt: TileLayers.LayerType) -> Vector2i:
	match lt:
		TileLayers.LayerType.FLOOR:
			return Vector2i(randi_range(3, 8), 0)
		TileLayers.LayerType.WALL:
			return Vector2i(2, 0)
		TileLayers.LayerType.TARGET:
			return Vector2i(9, 0)
		TileLayers.LayerType.TARGET_BOX:
			return Vector2i(0, 0)
		TileLayers.LayerType.BOX:
			return Vector2i(1, 0)
	return Vector2i.ZERO


func add_tile(
	lt: TileLayers.LayerType,
	tile_coord: Vector2i,
	map_layer: TileMapLayer
) -> void:
	var atlas_coord: Vector2i = get_atlas_coord_for_layer_type(lt)
	map_layer.set_cell(tile_coord, SOURCE_ID, atlas_coord)


func setup_layer(
	lt: TileLayers.LayerType,
	map_layer: TileMapLayer,
	ll: LevelLayout
) -> void:
	var tiles_array: Array[Vector2i] = ll.get_tiles_for_layer(lt)
	for tc in tiles_array:
		add_tile(lt, tc, map_layer)


func clear_tiles() -> void:
	for tl in tile_layers.get_children():
		tl.clear()


func move_camera() -> void:
	
	var tmr: Rect2i = floor_tiles.get_used_rect()
	
	var tm_w_x: float = tmr.size.x * LevelData.TILE_SIZE
	var tm_w_y: float = tmr.size.y * LevelData.TILE_SIZE
	
	var mid_x: float = tm_w_x / 2  + (tmr.position.x * LevelData.TILE_SIZE)
	var mid_y: float = tm_w_y / 2  + (tmr.position.y * LevelData.TILE_SIZE)
	
	camera_2d.position = Vector2(mid_x, mid_y)


func setup_level() -> void:
	var ln: String = GameManager.get_level_selected()
	var layout: LevelLayout = LevelData.get_level_data(ln)
	
	_total_moves = 0
	
	clear_tiles()
	setup_layer(TileLayers.LayerType.FLOOR, floor_tiles, layout)
	setup_layer(TileLayers.LayerType.WALL, wall_tiles, layout)
	setup_layer(TileLayers.LayerType.TARGET, targets_tiles, layout)
	setup_layer(TileLayers.LayerType.BOX, boxes_tiles, layout)
	setup_layer(TileLayers.LayerType.TARGET_BOX, boxes_tiles, layout)
	
	place_player_on_tile(layout.get_player_start())
	
	move_camera()
	
	hud.new_game(ln)
	game_over_ui.new_game()
	
	_game_over = false
