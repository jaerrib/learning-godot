extends Node


const LEVEL_DATA_PATH: String = "res://data/level_data.json"
const TILE_SIZE: int = 32


var _level_data: Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_level_data()


func setup_level(lns: String, raw_level__data: Dictionary) -> LevelLayout:
	var layout: LevelLayout = LevelLayout.new()
	var ps = raw_level__data.player_start
	layout.set_player_start(ps.x, ps.y)
	return layout

func load_level_data() -> void:
	var file = FileAccess.open(LEVEL_DATA_PATH, FileAccess.READ)
	var raw_data = JSON.parse_string(file.get_as_text())

	for lns in raw_data.keys():
		_level_data[lns] = setup_level(lns, raw_data[lns])
