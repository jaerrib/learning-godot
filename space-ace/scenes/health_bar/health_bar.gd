extends TextureProgressBar


class_name HealthBar


signal died


@export var level_low: int = 30
@export var level_med: int = 65
@export var start_health: int = 100
@export var max_health: int = 100


const COLOR_DANGER: Color = Color("#cc0000")
const COLOR_MIDDLE: Color = Color("#ff9900")
const COLOR_GOOD: Color = Color("#33cc33")

var _dead: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = max_health
	value = start_health
	set_color()


func set_color() -> void:
	if value < level_low:
		tint_progress = COLOR_DANGER
	elif value < level_med:
		tint_progress = COLOR_MIDDLE
	else:
		tint_progress = COLOR_GOOD


func incr_value(v: int) -> void:
	if _dead == true: 
		return
	value += v
	if value <= 0:
		_dead = true
		died.emit()
	set_color()
	
	
func reset_health() -> void:
	_dead = false
	value = max_health
	set_color()
	
	
func take_damage(v: int) -> void:
	incr_value(-v)
