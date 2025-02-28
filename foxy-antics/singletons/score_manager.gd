extends Node


var _score: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_enemy_hit.connect(update_score)
	SignalManager.on_pickup_hit.connect(update_score)


func update_score(p: int) -> void:
	_score += p
	SignalManager.on_score_updated.emit(_score)
