class_name TileLayers


enum LayerType { FLOOR, WALL, TARGET, BOX, TARGET_BOX }


var _floor: Array[Vector2i]
var _wall: Array[Vector2i]
var _targets: Array[Vector2i]
var _boxes: Array[Vector2i]
var _target_boxes: Array[Vector2i]

var _layer_coords: Dictionary = {
	LayerType.FLOOR: _floor,
	LayerType.WALL: _wall,
	LayerType.TARGET: _targets,
	LayerType.BOX: _boxes,
	LayerType.TARGET_BOX: _target_boxes,
}


func add_coord(coord: Vector2i, lt: LayerType) -> void:
	_layer_coords[lt].push_back(coord)


func get_tiles_for_layer(lt: LayerType) -> Array[Vector2i]:
	return _layer_coords[lt]
