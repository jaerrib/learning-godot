extends Node2D

class_name Pipes


@onready var score_sound: AudioStreamPlayer2D = $ScoreSound
@onready var von: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D


func _ready() -> void:
	SignalManager.on_plane_died.connect(on_plane_died)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= GameManager.SCROLL_SPEED * delta
	check_off_screen() 


func check_off_screen() -> void:
	if von.global_position.x < get_viewport_rect().position.x :
		queue_free()


func on_plane_died() -> void:
	set_process(false)


func _on_pipe_body_entered(body: Node2D) -> void:
	if body is Tappy:
		body.die()
	#if body.is_in_group(GameManager.GROUP_PLANE):
		#if body.has_method("die"):
			#body.die()


func _on_laser_body_entered(body: Node2D) -> void:
	if body is Tappy:
		score_sound.play()
		ScoreManager.increment_score()  
