extends PathFollow2D


class_name EnemyBase


@export var shoots_at_player: bool = false
@export var aims_at_player: bool = false

@export var bullet_type: BaseBullet.BulletType
@export var bullet_speed: float = 120.0
@export var bullet_direction: Vector2 = Vector2.DOWN
@export var bullet_wait_time: float = 3.0
@export var bullet_wait_time_var: float = 0.5
@export var power_up_chance: float = 0.7
@export var kill_me_score: int = 10

@onready var laser_timer: Timer = $LaserTimer
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: HealthBar = $HealthBar
@onready var booms: Node2D = $Booms


const SPAWN_CHANCE: float = 0.20


var _speed: float = 50.0
var _player_ref: Player
var _dead: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(GameManager.GROUP_PLAYER)
	if !_player_ref:
			queue_free()
	start_shoot_timer()
	SpaceUtils.play_random_animation(animated_sprite_2d)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += _speed * delta
	if progress_ratio > 0.99:
		queue_free()


func start_shoot_timer() -> void:
	SpaceUtils.set_and_start_timer(
		laser_timer,
		bullet_wait_time,
		bullet_wait_time_var,
	)


func setup(speed: float) -> void:
	_speed = speed


func update_bullet_direction() -> void:
	if aims_at_player == false: 
		return
	
	if is_instance_valid(_player_ref) == false:
		return
		
	bullet_direction = global_position.direction_to(
		_player_ref.global_position
	)


func shoot() -> void:
	if shoots_at_player == false:
		return
	update_bullet_direction()
	SignalManager.on_create_bullet.emit(
		global_position, 
		bullet_direction,
		bullet_speed, 
		bullet_type
	)
	SoundManager.play_laser_random(sound)
	start_shoot_timer()


func _on_laser_timer_timeout() -> void:
	shoot()


func make_booms() -> void:
	for b in booms.get_children():
		SignalManager.on_create_explosion.emit(
			b.global_position, 
			Explosion.ExplosionType.BOOM

		)


func create_power_up() -> void:
	if randf()  < power_up_chance:
		SignalManager.on_create_power_up_random.emit(global_position)


func die() -> void:
	if _dead == true:
		return
	_dead = true
	create_power_up()
	make_booms()
	ScoreManager.increment_score(kill_me_score)
	queue_free()	


func _on_health_bar_died() -> void:
	die() 


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area is BaseBullet:
		health_bar.take_damage(area.get_damage())
