extends Node2D


const ENEMY_BOMB = preload("res://scenes/bullets/enemy_bomb.tscn")
const ENEMY_BULLET = preload("res://scenes/bullets/enemy_bullet.tscn")
const PLAYER_BULLET = preload("res://scenes/bullets/player_bullet.tscn")
const POWER_UP = preload("res://scenes/power_up/power_up.tscn")
const EXPLOSION = preload("res://scenes/explosion/explosion.tscn")
const HOMING_MISSILE = preload("res://scenes/homing_missile/homing_missile.tscn")	
const ADD_OBJECT: String = "add_object"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_create_bullet.connect(on_create_bullet)
	SignalManager.on_create_power_up.connect(on_create_power_up)
	SignalManager.on_create_explosion.connect(on_create_explosion)
	SignalManager.on_create_power_up_random.connect(on_create_power_up_random)
	SignalManager.on_create_homing_missile.connect(on_create_homing_missile)


func add_object(obj: Node, global_position: Vector2) -> void:
	add_child(obj)
	obj.global_position = global_position


func on_create_explosion(start_pos: Vector2, et: Explosion.ExplosionType) -> void:
	var scene: Explosion = EXPLOSION.instantiate()
	scene.setup(et)
	call_deferred(ADD_OBJECT, scene, start_pos)


func on_create_power_up(start_pos: Vector2, pu_type: PowerUp.PowerUpType) -> void:
	var pu: PowerUp = POWER_UP.instantiate()
	pu.set_power_up_type(pu_type)
	call_deferred(ADD_OBJECT, pu, start_pos)


func on_create_power_up_random(start_pos: Vector2) -> void:
	var rpu: PowerUp.PowerUpType = PowerUp.PowerUpType.values().pick_random()
	on_create_power_up(start_pos, rpu)


func on_create_bullet(start_pos: Vector2, dir: Vector2, speed: float, bu_type: BaseBullet.BulletType ) -> void:
	var scene: BaseBullet
	match bu_type:
		BaseBullet.BulletType.PLAYER:
			scene = PLAYER_BULLET.instantiate()
			var player: Player = get_tree().get_first_node_in_group(GameManager.GROUP_PLAYER)
			if player.is_boosted:
				var sprite: Sprite2D = scene.get_node("Sprite2D")
				sprite.modulate = Color(255, 255, 0)
			scene.damage = player.get_player_damage()
		BaseBullet.BulletType.ENEMY:
			scene = ENEMY_BULLET.instantiate()
		BaseBullet.BulletType.ENEMYBOMB:
			scene = ENEMY_BOMB.instantiate()
	if scene:
		scene.setup(dir, speed)
		call_deferred(ADD_OBJECT, scene, start_pos)


func on_create_homing_missile(start_pos: Vector2) -> void:
	var hm: HomingMissle = HOMING_MISSILE.instantiate()
	call_deferred(ADD_OBJECT, hm, start_pos)
