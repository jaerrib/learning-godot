extends TextureRect


const SCALE_SMALL: Vector2 = Vector2(0.1, 0.1)
const SCALE_NORMAL : Vector2 = Vector2(1.0, 1.0)
const SPIN_TIME_RANGE: Vector2 = Vector2(1.0, 2.0)
const SCALE_TIME: float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_random_image()
	run_me()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_random_image() -> void:
	texture = ImageManager.get_random_item_image().get_texture()


func get_random_spin_time() -> float:
	return randf_range(SPIN_TIME_RANGE.x, SPIN_TIME_RANGE.y)


func get_random_rotation() -> float:
	return deg_to_rad(randf_range(-360, 360))

func run_me() -> void:
	# make tween
	var tween: Tween = get_tree().create_tween()
	# scale -> small
	tween.tween_property(self, "scale", SCALE_SMALL, SCALE_TIME)
	# set_random_image
	tween.tween_callback(set_random_image)
	# scale -> big
	tween.tween_property(self, "scale", SCALE_NORMAL, SCALE_TIME)
	# rotation rand amt, rand time
	tween.tween_property(self, "rotation", get_random_rotation(), get_random_spin_time())
	# run_me
	tween.tween_callback(run_me)
