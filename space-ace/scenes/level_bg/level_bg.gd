extends ParallaxBackground


const SPEED: float = 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scroll_offset.y += SPEED * delta
