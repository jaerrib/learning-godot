extends Node


@export  var life_s: float = 30.0
@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = life_s
	timer.start()


func _on_timer_timeout() -> void:
	var p: Node = get_parent()
	p.queue_free()
