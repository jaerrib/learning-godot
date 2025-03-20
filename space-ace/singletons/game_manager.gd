extends Node

const GROUP_PLAYER: String = "Player"
const LEVEL = preload("res://scenes/level/level.tscn")
const MAIN = preload("res://scenes/main/main.tscn")


func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)


func load_level_scene() -> void:
	get_tree().change_scene_to_packed(LEVEL)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
