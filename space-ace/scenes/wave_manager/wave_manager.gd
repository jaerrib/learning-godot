extends Node2D


const WAVES: EnemyWaves = preload("res://resources/waves.tres")


@onready var paths: Node2D = $Paths
@onready var spawn_timer: Timer = $SpawnTimer


var _wave_count: int = 0
var _last_path_index: int = -1
var _wave_gap: float = 4.0
var _paths_list: Array = []
var _speed_factor: float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_paths_list = paths.get_children()
	spawn_wave()


func set_random_path_index() -> void:
	var all_indexes: Array = range(len(_paths_list))
	all_indexes.erase(_last_path_index)
	_last_path_index = all_indexes.pick_random()


func update_speeds() -> void:
	if WAVES.wave_is_start(_wave_count):
		#_speed_factor += 1
		_wave_gap *= 0.97


func create_enemy(wave: EnemyWave) -> EnemyBase:
	var new_en: EnemyBase = wave.get_enemy_scene().instantiate()
	new_en.setup(wave.get_speed() * _speed_factor)
	return new_en


func start_spawn_timer() -> void:
	spawn_timer.wait_time = _wave_gap
	spawn_timer.start()


func spawn_wave() -> void:
	set_random_path_index()
	
	var path: Path2D = _paths_list[_last_path_index]
	var wave: EnemyWave = WAVES.get_wave_for_wave_count(_wave_count)
	
	for i in range(0, wave.get_number()):
		path.add_child(create_enemy(wave))
		await get_tree().create_timer(wave.get_gap()).timeout
	
	#print("wave() %d spawned, waiting %s" % [_wave_count, wave.get_gap()])
	_wave_count += 1
	start_spawn_timer()
	update_speeds()
	

func _on_spawn_timer_timeout() -> void:
	spawn_wave()
