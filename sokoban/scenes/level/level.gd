extends Node2D


const SOURCE_ID = 1


@onready var tile_layers: Node2D = $TileLayers
@onready var floor_tiles: TileMapLayer = $TileLayers/Floor
@onready var wall_tiles: TileMapLayer = $TileLayers/Wall
@onready var targets_tiles: TileMapLayer = $TileLayers/Targets
@onready var boxes_tiles: TileMapLayer = $TileLayers/Boxes
@onready var player: AnimatedSprite2D = $Player


var _total_moves: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
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
