extends Area2D


class_name Player


@export var speed: float = 200.0
@export var bullet_speed: float = 280.0
@export var bullet_direction: Vector2 = Vector2.UP
@export var health_boost: int = 20
@export var laser_boost: int = 10

 
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shield: Shield = $Shield
@onready var sound: AudioStreamPlayer2D = $Sound


const MARGIN: float = 16.0


var _upper_left: Vector2
var _lower_right: Vector2
@export var _player_damage: int = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_limits()
	SignalManager.on_increase_player_damage.connect(on_increase_player_damage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = get_input()
	global_position += input * delta * speed
	global_position = global_position.clamp(_upper_left, _lower_right)
	if Input.is_action_just_pressed("shoot"):
		shoot()


func shoot() -> void:
	SignalManager.on_create_bullet.emit(
		global_position,
		bullet_direction,
		bullet_speed,
		BaseBullet.BulletType.PLAYER,
	)
	SoundManager.play_laser_random(sound)


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
				SignalManager.on_player_health_bonus.emit(health_boost)
			PowerUp.PowerUpType.SHIELD:
				shield.enable_shield()
			PowerUp.PowerUpType.LASER:
				SignalManager.on_increase_player_damage.emit(laser_boost)
	elif area is HitBox:
		SignalManager.on_player_hit.emit(area.get_damage())


func on_increase_player_damage(boost: int) -> void:
	_player_damage += boost


func get_player_damage() -> int:
	return _player_damage
