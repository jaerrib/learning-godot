extends CanvasLayer


@onready var main: Control = $Main
@onready var game: Control = $Game
@onready var sound: AudioStreamPlayer = $Sound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_game_exit_pressed()
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)
	SignalManager.on_level_selected.connect(on_level_selected )


func show_game(s: bool ) -> void:
	game.visible = s
	main.visible = !s


func on_game_exit_pressed() -> void:
	show_game(false)
	SoundManager.play_sound(sound, SoundManager.SOUND_MAIN_MENU)


func on_level_selected(level_num: int) -> void:
	show_game(true)
	SoundManager.play_sound(sound, SoundManager.SOUND_IN_GAME)
