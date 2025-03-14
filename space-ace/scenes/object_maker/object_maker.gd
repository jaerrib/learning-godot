extends Node2D


const ENEMY_BOMB = preload("res://scenes/bullets/enemy_bomb.tscn")
const ENEMY_BULLET = preload("res://scenes/bullets/enemy_bullet.tscn")
const PLAYER_BULLET = preload("res://scenes/bullets/player_bullet.tscn")

const ADD_OBJECT: String = "add_object"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_create_bullet.connect(on_create_bullet)


func add_object(obj: Node, global_position: Vector2) -> void:
	add_child(obj)
	obj.global_position = global_position


func on_create_bullet(start_pos: Vector2, dir: Vector2, speed: float, bu_type: BaseBullet.BulletType ) -> void:
	var scene: BaseBullet
	match bu_type:
		BaseBullet.BulletType.PLAYER:
			scene = PLAYER_BULLET.instantiate()
		BaseBullet.BulletType.ENEMY:
			scene = ENEMY_BULLET.instantiate()
		BaseBullet.BulletType.ENEMYBOMB:
			scene = ENEMY_BOMB.instantiate()
	if scene:
		scene.setup(dir, speed)
		call_deferred(ADD_OBJECT, scene, start_pos)
	
