extends Control


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()


func _on_return_to_menu_pressed() -> void:
	GameManager.load_main_scene()
