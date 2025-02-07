extends TextureButton


@export var level_number: int = 1

@onready var label: Label = $Label
@onready var sound: AudioStreamPlayer = $Sound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ldata: LevelData = GameManager.get_level(level_number)
	label.text = "%dx%d" % [ldata.get_cols(), ldata.get_rows()]


func _on_pressed() -> void:
	SoundManager.play_button_click(sound)
	SignalManager.on_level_selected.emit(level_number)
