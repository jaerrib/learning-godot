extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		GameManager.load_main_scene()
	if Input.is_action_just_pressed("maker"):
		#SignalManager.on_create_bullet.emit(
				#Vector2(339, 100),
				#Vector2.DOWN,
				#150,
				#BaseBullet.BulletType.ENEMY)
				
		SignalManager.on_create_power_up.emit(
				Vector2(339, 100),
				PowerUp.PowerUpType.HEALTH)
