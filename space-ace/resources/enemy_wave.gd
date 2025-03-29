extends Resource


class_name EnemyWave

@export var enemy_scene: PackedScene
@export var speed: float
@export var gap: float
@export var number: int


func get_enemy_scene() -> PackedScene:
	return enemy_scene


func get_speed() -> float:
	return speed


func get_gap() -> float:
	return gap


func get_number() -> int:
	return number
