extends PathFollow2D


class_name Saucer


const SPEED: float = 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += SPEED * delta
		
	if progress_ratio > 0.99:
		queue_free()
