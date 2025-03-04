class_name LevelLayout


var _player_start: Vector2i = Vector2i.ZERO


func set_player_start(tile_x: int, tile_y: int) -> void:
	_player_start = Vector2i(tile_x, tile_y)


func get_player_start() -> Vector2i:
	return _player_start
