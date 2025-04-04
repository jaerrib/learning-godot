extends Area2D


class_name Player


@export var speed: float = 200.0
@export var bullet_speed: float = 280.0
@export var bullet_direction: Vector2 = Vector2.UP
@export var health_boost: int = 20
@export var laser_boost: int = 10
@export var is_boosted: bool = false
@export var player_lives: int = 3


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shield: Shield = $Shield
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var laser_boost_timer: Timer = $LaserBoostTimer
@onready var double_shot_timer: Timer = $DoubleShotTimer
@onready var shot_timer: Timer = $ShotTimer
@onready var spread_timer: Timer = $SpreadTimer
@onready var multishot_timer: Timer = $MultishotTimer
@onready var booms: Node2D = $Booms


const MARGIN: float = 16.0
const BASE_DAMAGE: int = 10
const BASE_WAIT: int = 10


var _upper_left: Vector2
var _lower_right: Vector2
var _player_damage: int = 10
var _has_double_shot: bool = false
var _has_spread: bool = false
var _is_shooting: bool = false
var _has_multishot: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_limits()
	SignalManager.on_increase_player_damage.connect(on_increase_player_damage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = get_input()
	global_position += input * delta * speed
	global_position = global_position.clamp(_upper_left, _lower_right)
	if Input.is_action_pressed("shoot"):
		if !_is_shooting:
			shot_timer.start()
			_is_shooting = true


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


func multishoot() -> void:
	var directions: Array[Vector2] = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]
	for direction in directions:
		SignalManager.on_create_bullet.emit(
			global_position,
			direction,
			bullet_speed,
			BaseBullet.BulletType.PLAYER,
		)

func spread_shot() -> void:
	var directions: Array[Vector2] = [
		Vector2(-1, -6).normalized(),
		Vector2(-1, -3).normalized(),
		Vector2.UP,
		Vector2(1, -3) 
		.normalized(),
		Vector2(1, -6).normalized(),
		]
	for direction in directions:
		SignalManager.on_create_bullet.emit(
			global_position,
			direction,
			bullet_speed,
			BaseBullet.BulletType.PLAYER,
		)


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
			PowerUp.PowerUpType.NUKE:
				nuke()
			PowerUp.PowerUpType.SPREAD:
				_has_spread = true
				spread_timer.start()
			PowerUp.PowerUpType.MULTI:
				_has_multishot = true
				multishot_timer.start()
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


func nuke() -> void:
	SignalManager.on_nuke_activated.emit()


func _on_shot_timer_timeout() -> void:
	select_shot_type()
	_is_shooting = false


func select_shot_type() -> void:
	SoundManager.play_laser_random(sound)
	if _has_spread:
		spread_shot()
	elif _has_multishot:
		multishoot()
	elif _has_double_shot:
		double_shoot()
	else:
		shoot()


func _on_multishot_timer_timeout() -> void:
	_has_multishot = false


func make_booms() -> void:
	for b in booms.get_children():
		SignalManager.on_create_explosion.emit(
			b.global_position, 
			Explosion.ExplosionType.BOOM
		)


func _on_spread_timer_timeout() -> void:
	_has_spread = false
