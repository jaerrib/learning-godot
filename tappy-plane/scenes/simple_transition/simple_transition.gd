extends Control


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_packed(GameManager.next_scene)
