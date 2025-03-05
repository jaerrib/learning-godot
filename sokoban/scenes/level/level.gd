extends Node2D


const SOURCE_ID = 1


@onready var tile_layers: Node2D = $TileLayers
@onready var floor: TileMapLayer = $TileLayers/Floor
@onready var wall: TileMapLayer = $TileLayers/Wall
@onready var targets: TileMapLayer = $TileLayers/Targets
@onready var boxes: TileMapLayer = $TileLayers/Boxes
@onready var player: AnimatedSprite2D = $Player


var _total_moves: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func clear_tiles() -> void:
	for tl in tile_layers.get_children():
		tl.clear()


func setup_level() -> void:
	var ln: String = GameManager.get_level_selected()
	var layout: LevelLayout = LevelData.get_level_data(ln)
	
	_total_moves = 0
	
	clear_tiles()
