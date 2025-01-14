extends ParallaxLayer


const IMAGE_WIDTH: float = 1920.0
const IMAGE_HEIGHT: float = 1080.0


@onready var sprite_2d: Sprite2D = $Sprite2D


@export var texture: Texture2D
@export var scroll_scale: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	motion_scale.x = scroll_scale
	var scale_factor = get_viewport_rect().size.y / IMAGE_HEIGHT
	sprite_2d.texture = texture
	sprite_2d.scale = Vector2(scale_factor, scale_factor)
	motion_mirroring.x = IMAGE_WIDTH * scale_factor
