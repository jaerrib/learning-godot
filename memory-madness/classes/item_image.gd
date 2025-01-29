class_name ItemImage


var _item_name: String
var _item_texture: Texture2D


func _init(item_name: String, item_texture: Texture2D) -> void:
	_item_name = item_name
	_item_texture = item_texture


func get_texture() -> Texture2D:
	return _item_texture


func get_item_name() -> String:
	return _item_name
