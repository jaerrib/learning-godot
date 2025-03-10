extends Control


class_name GameOverUI

@onready var moves_label: Label = $MC/NinePatchRect/VBoxContainer/MovesLabel
@onready var record_label: Label = $MC/NinePatchRect/VBoxContainer/RecordLabel


func new_game() -> void:
	record_label.hide()
	hide()
	
	
func game_over(level: String, moves: int) -> void:
	moves_label.text = "%d moves taken!" % moves
	record_label.visible = ScoreSync.score_is_new_best(level, moves)
	show()
