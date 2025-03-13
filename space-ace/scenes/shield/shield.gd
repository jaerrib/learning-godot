extends Area2D


class_name Shield


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sound: AudioStreamPlayer2D = $Sound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enable_shield()


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
