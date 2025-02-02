extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_level_selected.connect(on_level_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_level_selected(level_num: int) -> void:
	pass


func _on_exit_button_pressed() -> void:
	SignalManager.on_game_exit_pressed.emit()
