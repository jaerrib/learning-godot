extends Control


const HIGH_SCORE_LABEL = preload("res://scenes/high_score_label/high_score_label.tscn")


@onready var grid_container: GridContainer = $MarginContainer/GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_scores()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		GameManager.load_next_level_scene()
	

func set_scores() -> void:
	for c in grid_container.get_children():
		grid_container.remove_child(c)
	for s in ScoreManager.get_score_history():
		var lb: Label = HIGH_SCORE_LABEL.instantiate()
		lb.text = "%04d" % s
		grid_container.add_child(lb)
