extends Area2D


class_name Player


@export var speed: float = 200.0
@export var bullet_speed: float = 280.0
@export var bullet_direction: Vector2 = Vector2.UP
@export var health_boost: int = 20
@export var laser_boost: int = 10
@export var is_boosted: bool = false


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shield: Shield = $Shield
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var laser_boost_timer: Timer = $LaserBoostTimer
@onready var double_shot_timer: Timer = $DoubleShotTimer


const MARGIN: float = 16.0
const BASE_DAMAGE: int = 10
const BASE_WAIT: int = 10


var _upper_left: Vector2
var _lower_right: Vector2
var _player_damage: int = 10
var _has_double_shot: bool = false

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
		if _has_double_shot:
			double_shoot()
		else:
			shoot()


func double_shoot() -> void:
	SignalManager.on_create_bullet.emit(
		Vector2(global_position.x - 10, global_position.y),
		bullet_direction,
		bullet_speed,
		BaseBullet.BulletType.PLAYER,
	)
	SignalManager.on_create_bullet.emit(
		Vector2(global_position.x + 10, global_position.y),
		bullet_direction,
		bullet_speed,
		BaseBullet.BulletType.PLAYER,
	)
	SoundManager.play_laser_random(sound)

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
			PowerUp.PowerUpType.DOUBLE:
				add_double_shot()
	elif area is HitBox:
		SignalManager.on_player_hit.emit(area.get_damage())


func add_double_shot() -> void:
	if _has_double_shot:
		double_shot_timer.stop()
	_has_double_shot = true
	double_shot_timer.start()


func on_increase_player_damage(boost: int) -> void:
	_player_damage += boost
	is_boosted = true
	if laser_boost_timer.is_stopped():
		laser_boost_timer.start()
	else:
		extend_timer()


func extend_timer() -> void:
	var new_time = laser_boost_timer.time_left + BASE_WAIT
	laser_boost_timer.stop()
	laser_boost_timer.wait_time = new_time
	laser_boost_timer.start()	


func get_player_damage() -> int:
	return _player_damage


func _on_laser_boost_timer_timeout() -> void:
	_player_damage = BASE_DAMAGE
	laser_boost_timer.wait_time = BASE_WAIT
	is_boosted = false


func _on_double_shot_timer_timeout() -> void:
	_has_double_shot = false
