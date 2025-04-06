extends Control


const PLAYER = preload("res://scenes/player/player.tscn")


@onready var health_bar: HealthBar = $ColorRect/MC/HealthBar
@onready var score_label: Label = $ColorRect/MC/ScoreLabel
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var restart_timer: Timer = $RestartTimer
@onready var lives_label: Label = $ColorRect/MC/LivesLabel


var _player_lives: int = 3
var _extra_life_threshold: int = 5000


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player: Player = get_tree().get_first_node_in_group(GameManager.GROUP_PLAYER)
	set_life_label()
	SignalManager.on_player_hit.connect(on_player_hit)
	SignalManager.on_player_health_bonus.connect(on_player_health_bonus)
	SignalManager.on_score_updated.connect(on_score_updated)
	SignalManager.on_player_life_lost.connect(set_life_label)


func on_player_hit(dmg: int) -> void:
	health_bar.take_damage(dmg)


func on_score_updated(v: int) -> void:
	score_label.text = "%06d" % v
	check_for_extra_life()


func check_for_extra_life()	-> void:
	if ScoreManager.get_score() > _extra_life_threshold:
		_player_lives += 1
		_extra_life_threshold += 5000
		set_life_label()
	


func set_life_label() -> void:
	lives_label.text = str(_player_lives - 1)


func _on_health_bar_died() -> void:
	var player: Player = get_tree().get_first_node_in_group(GameManager.GROUP_PLAYER)
	player.make_booms()
	_player_lives -=1
	SignalManager.on_player_life_lost.emit()
	if _player_lives <= 0:
		SignalManager.on_player_died.emit()
		ScoreManager.save_high_score_to_file()
	else:
		player.queue_free()
		restart_timer.start()


func on_player_health_bonus(boost: int) -> void:
	health_bar.incr_value(boost)
	SoundManager.play_power_up_sound(PowerUp.PowerUpType.HEALTH, sound)


func _on_restart_timer_timeout() -> void:
	if PLAYER:
		var new_player = PLAYER.instantiate()
		get_parent().add_child(new_player)
		new_player.position = Vector2(320, 420)
		health_bar.reset_health()
