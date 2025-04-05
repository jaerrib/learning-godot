extends Control


class_name PauseMenu


func _notification(what: int) -> void:
	match what:
		Node.NOTIFICATION_PAUSED:
			hide()
		Node.NOTIFICATION_UNPAUSED:
			show()
