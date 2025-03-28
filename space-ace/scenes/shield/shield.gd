extends Area2D


class_name Shield


@export var start_health: int = 5


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var sprite_2d: Sprite2D = $Sprite2D


var _health: int = start_health


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enable_shield()


func _process(delta: float) -> void:
	SpaceUtils.sprite_flicker(sprite_2d)


func enable_shield() -> void:
	_health = start_health
	collision_shape_2d.call_deferred("set_disabled", false)
	timer.start()
	SoundManager.play_power_up_sound(PowerUp.PowerUpType.SHIELD, sound)
	show()

 
func disable_shield() -> void:
	timer.stop()
	hide()
	collision_shape_2d.call_deferred("set_disabled", true)


func hit() -> void:
	animation_player.play("hit")
	_health -= 1
	if _health <= 0:
		disable_shield()


func _on_timer_timeout() -> void:
	disable_shield()


func _on_area_entered(area: Area2D) -> void:
	hit()
