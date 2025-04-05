extends HitBox


class_name PowerUp


enum PowerUpType { HEALTH, SHIELD, LASER, DOUBLE, NUKE, SPREAD, MULTI }


const SPEED: float = 80.0

const TEXTURES: Dictionary = {
	PowerUpType.HEALTH: preload("res://assets/misc/powerupGreen_bolt.png"),
	PowerUpType.SHIELD: preload("res://assets/misc/shield_gold.png"),
	PowerUpType.LASER: preload("res://assets/misc/powerupPurple_bolt.png"),
	PowerUpType.DOUBLE: preload("res://assets/misc/powerupBlue_bolt.png"),
	PowerUpType.NUKE: preload("res://assets/misc/powerupRed_bolt.png"),
	PowerUpType.SPREAD: preload("res://assets/misc/powerupYellow_bolt.png"),
	PowerUpType.MULTI: preload("res://assets/misc/powerupWhite_bolt.png"),
}


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sound: AudioStreamPlayer2D = $Sound


var _power_up_type: PowerUpType = PowerUpType.HEALTH 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = TEXTURES[_power_up_type]
	SoundManager.play_powerup_deploy_sound(sound)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += delta * SPEED
	
	
func set_power_up_type(pu: PowerUpType) -> void:
	_power_up_type = pu


func get_Power_up_type() -> PowerUpType:
	return _power_up_type
	
	
func _on_area_entered(area: Area2D) -> void:
	queue_free()
