extends PathFollow2D


class_name EnemeyBase


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


var _speed: float = 50.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SpaceUtils.play_random_animation(animated_sprite_2d)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += _speed * delta
	
	if progress_ratio > 0.99:
		queue_free()

func setup(speed: float) -> void:
	_speed = speed
