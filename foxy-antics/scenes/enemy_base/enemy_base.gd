extends CharacterBody2D


class_name EnemyBase


const OFF_SCREEN_KILL_ME: float = 200.0


@export var points: int = 1


var _player_ref: Player
var _gravity: float = 800.0
var _dying: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	fallen_off()



func fallen_off() -> void:
	if global_position.y > OFF_SCREEN_KILL_ME:
		queue_free() 


func die() -> void:
	if _dying:
		return
	_dying = true
	set_physics_process(false)
	hide()
	# pick up, sound, and explosion
	SignalManager.on_enemy_hit.emit(points)
	SignalManager.on_create_object.emit(global_position, Constants.ObjectType.EXPLOSION)
	SignalManager.on_create_object.emit(global_position, Constants.ObjectType.PICKUP)
	queue_free()


func _on_hit_box_area_entered(area: Area2D) -> void:
	die()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	pass # Replace with function body.
