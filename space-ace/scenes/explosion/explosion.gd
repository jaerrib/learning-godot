extends AnimatedSprite2D


class_name Explosion


enum ExplosionType { EXPLOSION, BOOM }


const BOOM: String = "boom"
const EXPLOSION: String = "explosion"


@onready var sound: AudioStreamPlayer2D = $Sound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.play_explosion_random(sound)
	play()


func setup(et: ExplosionType) -> void:
	match et:
		ExplosionType.BOOM:
			animation = BOOM
		ExplosionType.EXPLOSION:
			animation = EXPLOSION


func _on_animation_finished() -> void:
	queue_free()	
