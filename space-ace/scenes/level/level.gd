extends Node2D


@onready var music: AudioStreamPlayer = $Music
@onready var wave_manager: Node2D = $WaveManager
@onready var pause_menu: Control = $CanvasLayer/PauseMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreManager.reset_score()
	SignalManager.on_player_died.connect(on_player_died)
	SignalManager.on_nuke_activated.connect(on_nuke_activated)


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE) or Input.is_action_just_pressed("exit"):
		GameManager.load_main_scene()
	#if Input.is_action_just_pressed("maker"):	
		#SignalManager.on_create_power_up.emit(
				#Vector2(339, 100),
				#PowerUp.PowerUpType.SPREAD)


func on_player_died() -> void:
	music.stop()
	for n in get_tree().get_nodes_in_group(GameManager.GROUP_MOVEABLES):
		if is_instance_valid(n):
			n.queue_free()
	var player: Player = get_tree().get_first_node_in_group(GameManager.GROUP_PLAYER)
	if player:
		player.queue_free()


func on_nuke_activated() -> void:
	var enemies = get_tree().get_nodes_in_group(GameManager.GROUP_ENEMIES)
	for enemy in enemies:
		if is_instance_valid(enemy):
			enemy.die()
