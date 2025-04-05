extends Node
class_name GamePlayManager


func _input(event) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()
		
		
func toggle_pause() -> void:
	get_tree().paused = !get_tree().paused
