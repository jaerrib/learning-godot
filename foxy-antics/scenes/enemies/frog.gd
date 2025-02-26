extends EnemyBase


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_timer: Timer = $JumpTimer
@onready var sound: AudioStreamPlayer2D = $Sound

const JUMP_MIN_TIME: float = 2.0
const JUMP_MAX_TIME: float = 4.0
const JUMP_VELOCITY_X: float = 100.0
const JUMP_VELOCITY_Y: float = 150.0
const JUMP_VELOCITY_R: Vector2 = Vector2(JUMP_VELOCITY_X, -JUMP_VELOCITY_Y)
const JUMP_VELOCITY_L: Vector2 = Vector2(-JUMP_VELOCITY_X, -JUMP_VELOCITY_Y)


var _jump: bool = false
var _seen_player: bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if not is_on_floor():
		velocity.y += _gravity * delta
	else:
		velocity.x = 0
		animated_sprite_2d.play("idle")
	apply_jump()
	move_and_slide()
	flip_me()


func flip_me() -> void:
	if(_player_ref.global_position.x > global_position.x and not animated_sprite_2d.flip_h):
		animated_sprite_2d.flip_h = true
	elif(_player_ref.global_position.x < global_position.x and animated_sprite_2d.flip_h):
		animated_sprite_2d.flip_h = false


func apply_jump() -> void:
	if is_on_floor() == false:
		return
	if _seen_player == false or _jump == false:
		return
	if animated_sprite_2d.flip_h == false:
		velocity = JUMP_VELOCITY_L
	else:
		velocity = JUMP_VELOCITY_R
	_jump = false
	animated_sprite_2d.play("jump")
	SoundManager.play_clip(sound, SoundManager.SOUND_JUMP)
	start_timer()


func start_timer() -> void:
	jump_timer.wait_time =  randf_range(JUMP_MIN_TIME, JUMP_MAX_TIME)
	jump_timer.start()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	_seen_player = true
	start_timer()


func _on_jump_timer_timeout() -> void:
	_jump = true
