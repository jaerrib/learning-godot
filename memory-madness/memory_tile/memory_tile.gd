extends TextureButton


class_name MemoryTile


@onready var frame_image: TextureRect = $FrameImage
@onready var item_image: TextureRect = $ItemImage


var _item_name: String
var _can_select_me: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_selection_enabled.connect(on_selection_enabled)
	SignalManager.on_selection_disabled.connect(on_selection_disabled)


func reveal(r: bool) -> void:
	frame_image.visible = r
	item_image.visible = r


func get_item_name() -> String:
	return _item_name


func setup(image: ItemImage, frame: Texture2D) -> void:
	frame_image.texture = frame
	item_image.texture = image.get_texture()
	_item_name = image.get_item_name()
	reveal(false)


func matches_other_tile(other: MemoryTile) -> bool:
	return other != self and other.get_item_name() == _item_name


func kill_on_success() -> void:
	z_index = 1
	
	var tween: Tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "disabled", true, 0)
	tween.tween_property(self, "rotation", 720, 0.5)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.5)
	tween.set_parallel(false)
	tween.tween_property(self, "rotation", 0, 0)
	tween.tween_interval(0.3)
	tween.tween_property(self, "scale", Vector2.ZERO, 0)


func on_selection_disabled() -> void:
	_can_select_me = false


func on_selection_enabled() -> void:
	_can_select_me = true


func _on_pressed() -> void:
	if _can_select_me and not frame_image.visible:
		SignalManager.on_tile_selected.emit(self)
