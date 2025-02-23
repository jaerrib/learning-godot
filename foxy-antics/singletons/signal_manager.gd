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


signal on_pickup_hit(points:int)
