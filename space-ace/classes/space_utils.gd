class_name SpaceUtils


static func play_random_animation(anim: AnimatedSprite2D) -> void:
	var animations: PackedStringArray = anim.sprite_frames.get_animation_names()
	var random_animation: String = animations[randi() % animations.size()]
	anim.play(random_animation)


static func sprite_flicker(sprite: Sprite2D) -> void:
	var flicker_amount: float = randf_range(1.0, 2.0)
	sprite.self_modulate = Color(flicker_amount, flicker_amount, flicker_amount)
