extends Control


@onready var health_bar: HealthBar = $ColorRect/MC/HealthBar
@onready var score_label: Label = $ColorRect/MC/ScoreLabel
@onready var sound: AudioStreamPlayer2D = $Sound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
