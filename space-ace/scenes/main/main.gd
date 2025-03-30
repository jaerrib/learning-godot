extends Control


@onready var high_score_label: Label = $MarginContainer/HighScoreLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var high_score: int = ScoreManager.get_high_score()
	high_score_label.text = "High Score: %06d" % high_score


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		GameManager.load_level_scene()
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()


func _on_play_button_pressed() -> void:
	GameManager.load_level_scene()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
