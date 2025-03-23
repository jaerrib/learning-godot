extends Control


@onready var health_bar: HealthBar = $ColorRect/MC/HealthBar
@onready var score_label: Label = $ColorRect/MC/ScoreLabel
@onready var sound: AudioStreamPlayer2D = $Sound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_player_hit.connect(on_player_hit)
	SignalManager.on_player_health_bonus.connect(on_player_health_bonus)


func on_player_hit(dmg: int) -> void:
	health_bar.take_damage(dmg)


func _on_health_bar_died() -> void:
	SignalManager.on_player_died.emit()


func on_player_health_bonus(boost: int) -> void:
	health_bar.incr_value(boost)
	SoundManager.play_power_up_sound(PowerUp.PowerUpType.HEALTH, sound)
