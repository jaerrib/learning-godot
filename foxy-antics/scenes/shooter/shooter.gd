extends Node2D


class_name Shooter


@onready var shoot_timer: Timer = $ShootTimer
@onready var sound: AudioStreamPlayer2D = $Sound


@export var speed: float = 50.0
@export var life_span: float = 10.0
@export var bullet_key: Constants.ObjectType
@export var shoot_delay: float = 0.7

var _can_shoot: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shoot_timer.wait_time = shoot_delay


func shoot(direction: Vector2) -> void:
	if not _can_shoot:
		return
	
	_can_shoot = false
	SignalManager.on_create_bullet.emit(
		global_position,
		direction,
		life_span,
		speed,
		bullet_key,
	)
	shoot_timer.start()
	SoundManager.play_clip(sound, SoundManager.SOUND_LASER)


func _on_shoot_timer_timeout() -> void:
	_can_shoot = true
