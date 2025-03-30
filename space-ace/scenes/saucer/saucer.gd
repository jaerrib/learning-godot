extends PathFollow2D


class_name Saucer


const SPEED: float = 20
const BOOM_DELAY: float = 0.1
const SCORE: int = 150
const WAIT_TIME: float = 7.0
const WAIT_VAR: float = 1.0
const PB: String = "parameters/playback"

@onready var tree: AnimationTree = $AnimationTree
@onready var s_mach: AnimationNodeStateMachinePlayback = tree[PB]
@onready var shoot_timer: Timer = $ShootTimer
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var hit_box: HitBox = $HitBox
@onready var health_bar: HealthBar = $HealthBar
@onready var booms: Node2D = $Booms


var _shooting: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	reset_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not _shooting:
		progress += SPEED * delta
		
	if progress_ratio > 0.99:
		queue_free()


func make_booms() -> void:
	for b in booms.get_children():
		SignalManager.on_create_explosion.emit(b.global_position, Explosion.ExplosionType.BOOM)
		await get_tree().create_timer(BOOM_DELAY).timeout


func stop_shooting() -> void:
	_shooting = false
	reset_timer()


func shoot() -> void:
	_shooting = true
	s_mach.travel("shoot")


func fire_missle() -> void:
	SignalManager.on_create_homing_missile.emit(global_position)


func reset_timer() -> void:
	SpaceUtils.set_and_start_timer(shoot_timer, WAIT_TIME, WAIT_VAR)


func _on_shoot_timer_timeout() -> void:
	shoot()


func _on_health_bar_died() -> void:
	health_bar.hide()
	make_booms()
	set_process(false)
	shoot_timer.stop()
	hit_box.deactivate()
	s_mach.travel("die")
	ScoreManager.increment_score(SCORE)


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area  is HitBox:
		health_bar.take_damage(area.get_damage())
