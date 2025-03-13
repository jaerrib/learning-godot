extends HitBox


class_name BaseBullet


enum BulletTYpe { PLAYER, ENEMY, ENEMYBOMB }


var _direction: Vector2 = Vector2.UP
var _speed: float = 200.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += _direction * _speed * delta


func setup(dir: Vector2, sp: float) -> void:
	_direction = dir.normalized()
	_speed = sp


func blow_up() -> void:
	set_process(false)
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	blow_up()
