extends Control


@onready var moves_label: Label = $NinePatchRect/MC/VBoxContainer/MovesLabel
@onready var sound: AudioStreamPlayer = $Sound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_game_over.connect(on_game_over)
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)


func on_game_over(moves: int) -> void:
	SoundManager.play_sound(sound, SoundManager.SOUND_GAME_OVER)
	moves_label.text = "You took %d moves" % moves
	show() 


func on_game_exit_pressed() -> void:
	hide()
