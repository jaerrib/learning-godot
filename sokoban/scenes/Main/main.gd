extends Control


const LEVEL_BUTTON = preload("res://scenes/level_button/level_button.tscn")
const LEVEL_COLS: int = 6
const LEVEL_ROWS: int = 5

@onready var level_buttons_container: GridContainer = $MC/VBoxContainer/LevelButtonsContainer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_grid()


func setup_grid() -> void:
	for level in range(LEVEL_COLS * LEVEL_ROWS):
		var lb = LEVEL_BUTTON.instantiate()
		level_buttons_container.add_child(lb)
