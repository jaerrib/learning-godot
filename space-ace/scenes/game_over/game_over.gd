extends Control


@onready var score_label: Label = $VB/ScoreLabel
@onready var timer: Timer = $Timer


var can_shoot: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	hide()
	SignalManager.on_player_died.connect(on_player_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_shoot == false:
		return
	if Input.is_action_just_pressed("shoot"):
		GameManager.load_main_scene()


func on_player_died() -> void:
	set_process(true)
	show()
	timer.start()
	score_label.text = "Score:%s (Best: %s)" % [
		ScoreManager.get_score(),
		ScoreManager.get_high_score()
	]

func _on_timer_timeout() -> void:
		can_shoot = true
