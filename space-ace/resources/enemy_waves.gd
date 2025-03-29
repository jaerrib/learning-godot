extends Resource


class_name EnemyWaves

@export var waves: Array[EnemyWave]

func get_wave_for_wave_count(wc: int) -> EnemyWave:
	return waves[wc % waves.size()]
