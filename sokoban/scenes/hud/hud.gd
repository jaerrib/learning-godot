extends Control


class_name Hud


@onready var level_label: Label = $MC/VB/HB/LevelLabel
@onready var moves_label: Label = $MC/VB/HB2/MovesLabel
@onready var best_label: Label = $MC/VB/HB3/BestLabel

 
func set_moves_label(moves: int) -> void:
	moves_label.text = str(moves)


func new_game(level: String) -> void:
	var best:int = ScoreSync.get_level_best_score(level)
	best_label.text = "-" if best == ScoreSync.DEFAULT_SCORE else str(best)

	level_label.text = level
	set_moves_label(0)
