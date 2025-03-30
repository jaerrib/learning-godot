extends PathFollow2D


class_name Saucer


const SPEED: float = 20
const WAIT_TIME: float = 7.0
const WAIT_VAR: float = 1.0
const PB: String = "parameters/playback"

@onready var tree: AnimationTree = $AnimationTree
@onready var s_mach: AnimationNodeStateMachinePlayback = tree[PB]
@onready var shoot_timer: Timer = $ShootTimer
@onready var sound: AudioStreamPlayer2D = $Sound


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


func stop_shooting() -> void:
	_shooting = false
	reset_timer()


func shoot() -> void:
	_shooting = true
	s_mach.travel("shoot")
	sound.play()


func reset_timer() -> void:
	SpaceUtils.set_and_start_timer(shoot_timer, WAIT_TIME, WAIT_VAR)


func _on_shoot_timer_timeout() -> void:
	shoot()
