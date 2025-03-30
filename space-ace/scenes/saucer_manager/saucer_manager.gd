extends Node2D


const SAUCER = preload("res://scenes/saucer/saucer.tscn")
const WAIT_TIME: float = 15.0
const WAIT_VARIATION: float = 3.0


@onready var timer: Timer = $Timer
@onready var paths: Node2D = $Paths


var _paths2ds: Array[Path2D] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for path in paths.get_children():
		if path is Path2D:
			_paths2ds.append(path)
	reset_timer()


func reset_timer() -> void:
	SpaceUtils.set_and_start_timer(timer, WAIT_TIME, WAIT_VARIATION)

  
func spawn_saucer() -> void:
	var saucer: Saucer = SAUCER.instantiate()
	var path: Path2D = _paths2ds.pick_random()
	path.add_child(saucer)
	reset_timer()


func _on_timer_timeout() -> void:
	spawn_saucer()
