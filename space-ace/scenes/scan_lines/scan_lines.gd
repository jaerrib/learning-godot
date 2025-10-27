class_name ScanLines extends ColorRect


func _ready() -> void:
	SignalManager.on_toggle_scanlines.connect(on_toggle_scanlines)
	visible = GameManager.scanlines


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle-scanlines"):
		SignalManager.on_toggle_scanlines.emit()


func on_toggle_scanlines() -> void:
	GameManager.scanlines = !GameManager.scanlines
	visible = GameManager.scanlines
	
