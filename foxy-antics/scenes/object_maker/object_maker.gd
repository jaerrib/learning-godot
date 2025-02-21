extends Node2D


const OBJECT_SCENES: Dictionary = {
	Constants.ObjectType.EXPLOSION: preload("res://scenes/explosion/explosion.tscn"),
	Constants.ObjectType.BULLET_PLAYER: preload("res://scenes/bullet_player/bullet_player.tscn"),
	Constants.ObjectType.BULLET_ENEMY: preload("res://scenes/bullet_enemy/bullet_enemy.tscn"), 
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_create_bullet.connect(on_create_bullet)
	SignalManager.on_create_object.connect(on_create_object)


func on_create_bullet(
	pos: Vector2,
	dir: Vector2,
	life_span: float,
	speed: float,
	ob_type: Constants.ObjectType,
	) -> void:
		if !OBJECT_SCENES.has(ob_type):
			return
		var nb: Bullet = OBJECT_SCENES[ob_type].instantiate()
		nb.setup(pos, dir, speed, life_span)
		call_deferred("add_child", nb)


func on_create_object(pos: Vector2, ob_type: Constants.ObjectType) -> void:
	if !OBJECT_SCENES.has(ob_type):
		return
	var n_obj = OBJECT_SCENES[ob_type].instantiate()
	n_obj.position = pos 
	call_deferred("add_child", n_obj)
