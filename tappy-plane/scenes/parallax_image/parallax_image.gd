extends Parallax2D


@onready var sprite_2d: Sprite2D = $Sprite2D
@export var texture: Texture2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = texture
	var scale_factor = get_viewport_rect().size.y / texture.get_height()
	sprite_2d.scale = Vector2(scale_factor, scale_factor)
	repeat_size.x = texture.get_width() * scale_factor
	SignalManager.on_plane_died.connect(on_plane_died)          


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	screen_offset.x += delta * GameManager.SCROLL_SPEED
	
	
func on_plane_died() -> void:
	set_process(false)
