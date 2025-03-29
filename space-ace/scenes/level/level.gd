extends Node2D


@onready var music: AudioStreamPlayer = $Music


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreManager.reset_score()
	SignalManager.on_player_died.connect(on_player_died)


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE) or Input.is_action_just_pressed("exit"):
		GameManager.load_main_scene()
	#if Input.is_action_just_pressed("maker"):	
		#SignalManager.on_create_power_up.emit(
				#Vector2(339, 100),
				#PowerUp.PowerUpType.LASER)


func on_player_died() -> void:
	music.stop()
	for n in get_tree().get_nodes_in_group(GameManager.GROUP_MOVEABLES):
		if is_instance_valid(n):
			n.queue_free()
	var player: Player = get_tree().get_first_node_in_group(GameManager.GROUP_PLAYER)
	if player:
		player.queue_free()
