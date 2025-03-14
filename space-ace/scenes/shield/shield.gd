extends Area2D


class_name Shield


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var sprite_2d: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enable_shield()


func _process(delta: float) -> void:
	var shield_flicker: float = randf_range(1.0, 2.0)
	sprite_2d.self_modulate = Color(shield_flicker, shield_flicker, shield_flicker)

func enable_shield() -> void:
	collision_shape_2d.call_deferred("set_disabled", false)
	timer.start()
	show()

 
func disable_shield() -> void:
	timer.stop()
	hide()
	collision_shape_2d.call_deferred("set_disabled", true)


func _on_timer_timeout() -> void:
	disable_shield()
