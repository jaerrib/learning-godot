class_name SpaceUtils


static func play_random_animation(anim: AnimatedSprite2D) -> void:
	var animations: PackedStringArray = anim.sprite_frames.get_animation_names()
	var random_animation: String = animations[randi() % animations.size()]
	anim.play(random_animation)
