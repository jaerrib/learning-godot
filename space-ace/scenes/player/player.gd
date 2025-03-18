extends Area2D


class_name Player


@export var speed: float = 250.0


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shield: Shield = $Shield


const MARGIN: float = 16.0


var _upper_left: Vector2
var _lower_right: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_limits()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = get_input()
	global_position += input * delta * speed
	global_position = global_position.clamp(_upper_left, _lower_right)


func get_input() -> Vector2:
	var v = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)
	if v.x != 0:
		animation_player.play("turn")
		sprite_2d.flip_h = true if v.x > 0 else false
	else:
		animation_player.play("fly")
	return v.normalized()


func set_limits() -> void:
	var vp: Rect2 = get_viewport_rect()
	_lower_right = Vector2(vp.size.x - MARGIN, vp.size.y - MARGIN)
	_upper_left = Vector2(MARGIN, MARGIN)


func _on_area_entered(area: Area2D) -> void:
	if area is PowerUp:
		match area.get_Power_up_type():
			PowerUp.PowerUpType.HEALTH:
				print("health")
			PowerUp.PowerUpType.SHIELD:
				shield.enable_shield()
