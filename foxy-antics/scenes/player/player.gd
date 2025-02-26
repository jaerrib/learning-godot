extends CharacterBody2D


class_name Player


enum PlayerState { IDLE, RUN, JUMP, FALL, HURT }


const FALLEN_OFF: float = 200.0
const GRAVITY: float = 690.0
const RUN_SPEED: float = 120.0
const MAX_FALL: float = 400.0
const JUMP_VELOCITY: float = -260.0
# I modifed the original tutorial code to add more granular control of the hurt jump
const HURT_JUMP_VELOCITY: float = -130.0
const KNOCKBACK: float = -50.0


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var debug_label: Label = $DebugLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shooter: Shooter = $Shooter
@onready var invincible_timer: Timer = $InvincibleTimer
@onready var invincible_player: AnimationPlayer = $InvinciblePlayer
@onready var hurt_timer: Timer = $HurtTimer


var _state: PlayerState = PlayerState.IDLE
var _invincible: bool = false
var _lives: int = 5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	fallen_off()
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	get_input()
	move_and_slide()
	calculate_state()
	update_debug_label()
	if Input.is_action_just_pressed("shoot"):
		shoot()


func fallen_off() -> void:
	if global_position.y < FALLEN_OFF:
		return
	reduce_lives(_lives)


func update_debug_label() -> void:
	debug_label.text = "floor:%s\n%s\nvel:(%.0f,%.0f)\n%s" % [
		 is_on_floor(), PlayerState.keys()[_state],velocity.x, velocity.y, global_position
	]

func shoot() -> void:
	if sprite_2d.flip_h:
		shooter.shoot(Vector2.LEFT)
	else:
		shooter.shoot(Vector2.RIGHT)


func get_input() -> void:
	if _state == PlayerState.HURT:
		return
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x = -RUN_SPEED
		sprite_2d.flip_h = true
	elif Input.is_action_pressed("right"):
		velocity.x = RUN_SPEED
		sprite_2d.flip_h = false
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)


func set_state(new_state: PlayerState) -> void:
	if new_state == _state:
		return
	_state = new_state
	match _state:
		PlayerState.IDLE:
			animation_player.play("idle")
		PlayerState.RUN:
			animation_player.play("run")
		PlayerState.JUMP:
			animation_player.play("jump")
		PlayerState.FALL:
			animation_player.play("fall")
		PlayerState.HURT:
			apply_hurt_jump()


func calculate_state() -> void:
	if _state == PlayerState.HURT:
		return
	if is_on_floor():
		if velocity.x == 0:
			set_state(PlayerState.IDLE)
		else:
			set_state(PlayerState.RUN)
	else:
		if velocity.y > 0:
			set_state(PlayerState.FALL)
		else:
			set_state(PlayerState.JUMP)


func reduce_lives(reduction: int) -> bool:
	_lives -= reduction
	SignalManager.on_player_hit.emit(_lives)
	if _lives <=0:
		SignalManager.on_game_over.emit()
		set_physics_process(false)
		print("PLAYER DIES")
		return false
	return true


func go_invincible() -> void:
	_invincible = true
	invincible_player.play("invincible")
	invincible_timer.start()


func apply_hurt_jump() -> void:
	animation_player.play("hurt")
	
	# I modified the original tutorial code to add a knockback effect
	velocity.x = KNOCKBACK * sign(velocity.x)	
	velocity.y = HURT_JUMP_VELOCITY
	
	hurt_timer.start()


func apply_hit() -> void:
	if _invincible:
		return
	if reduce_lives(1) == false:
		return 
	go_invincible()
	set_state(PlayerState.HURT)


func _on_invincible_timer_timeout() -> void:
	_invincible = false
	invincible_player.stop()


func _on_hit_box_area_entered(area: Area2D) -> void:
	apply_hit()


func _on_hurt_timer_timeout() -> void:
	set_state(PlayerState.IDLE)
