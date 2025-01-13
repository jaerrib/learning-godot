extends Node


@onready var score_label: Label = $ScoreLabel


var _score: int = 0
var _high_score: int = 0


func _ready() -> void:
	pass


func get_score() -> int:
	return _score


func get_high_score() -> int:
	return _high_score


func set_score(value: int) -> void:
	_score = value
	if _score > _high_score:
		_high_score = _score
	SignalManager.on_score_updated.emit(_score)


func increment_score() -> void:
	set_score(_score + 1)
