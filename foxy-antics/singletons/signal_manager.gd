extends Node


signal on_create_bullet(
	pos: Vector2,
	dir: Vector2,
	life_span: float,
	speed: float,
	ob_type: Constants.ObjectType,
	)


signal on_create_object(
	pos: Vector2,
	ob_type: Constants.ObjectType,
)


signal on_pickup_hit(points: int)
signal on_enemy_hit(points: int)
signal on_score_updated(score: int)
signal on_game_over
signal on_player_hit(lives: int)
signal on_level_started(lives: int)
