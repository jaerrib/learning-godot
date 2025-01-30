class_name LevelData

var _level_number: int
var _rows: int
var _cols: int


func _init(level_number: int, rows: int, cols: int) -> void:
	_level_number = level_number
	_rows = rows
	_cols = cols


func get_rows() -> int:
	return _rows


func get_cols() -> int:
	return _cols


func get_level_number() -> int:
	return _level_number


func get_target_pairs() -> int:
	return int((_rows * _cols) / 2)


func get_num_tiles() -> int:
	return _rows * _cols
