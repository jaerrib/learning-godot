extends Area2D


func _ready() -> void:
	pass


func _on_area_entered(_area: Area2D) -> void:
	var points: int = 100
	SignalManager.on_non_boss_level_passed.emit(points)
