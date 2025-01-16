extends Node


const GAME: PackedScene = preload("res://scenes/game/game.tscn")
const MAIN: PackedScene = preload("res://scenes/main/main.tscn")
const SIMPLE_TRANSITION: PackedScene = preload("res://scenes/simple_transition/simple_transition.tscn")
const SCROLL_SPEED: float = 120.0
const GROUP_PLANE: String = "Plane"

 
var next_scene: PackedScene


func load_next_scene(ns: PackedScene) -> void:
	next_scene = ns
	get_tree().change_scene_to_packed(SIMPLE_TRANSITION)


func load_game_scene() -> void:
	#get_tree().change_scene_to_packed(GAME)
	load_next_scene(GAME)


func load_main_scene() -> void:
	#get_tree().change_scene_to_packed(MAIN)
	load_next_scene(MAIN)
