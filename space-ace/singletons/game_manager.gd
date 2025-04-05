extends Node

const GROUP_PLAYER: String = "Player"
const GROUP_MOVEABLES: String = "Moveables"
const GROUP_ENEMIES: String = "Enemies"
const LEVEL = preload("res://scenes/level/level.tscn")
const MAIN = preload("res://scenes/main/main.tscn")
const HELP = preload("res://scenes/help_screen/help_screen.tscn")
const CREDITS =preload("res://scenes/credits_screen/credits_screen.tscn")


func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)


func load_level_scene() -> void:
	get_tree().change_scene_to_packed(LEVEL)


func load_help_screen() -> void:
	get_tree().change_scene_to_packed(HELP)


func load_credits_screen() -> void:
	get_tree().change_scene_to_packed(CREDITS)
