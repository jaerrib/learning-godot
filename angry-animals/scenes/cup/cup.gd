extends StaticBody2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func die() -> void:
	animation_player.play("vanish")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	SignalManager.on_cup_destroyed.emit()
	queue_free()
