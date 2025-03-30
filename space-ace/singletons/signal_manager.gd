extends Node


signal on_create_bullet(
	pos: Vector2, 
	dir: Vector2, 
	speed: float, 
	bull_type: BaseBullet.BulletType,
	)

signal on_create_power_up(pos: Vector2, pu_type: PowerUp.PowerUpType)

signal on_create_power_up_random(pos: Vector2)

signal on_create_explosion(pos: Vector2, et: Explosion.ExplosionType)
signal on_create_homing_missile(pos: Vector2)

signal on_player_hit(dmg: int)
signal on_player_health_bonus(dmg: int)
signal on_player_died
signal on_increase_player_damage(incr: int)
signal on_nuke_activated

signal on_score_updated(v: int)
