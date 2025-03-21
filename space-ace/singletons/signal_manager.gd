extends Node


signal on_create_bullet(
	pos: Vector2, 
	dir: Vector2, 
	speed: float, 
	bull_type: BaseBullet.BulletType,
	)

signal on_create_power_up(pos: Vector2, pu_type: PowerUp.PowerUpType)

signal on_create_explosion(pos: Vector2, et: Explosion.ExplosionType)
