extends Area2D


@onready var splash: AudioStreamPlayer2D = $Splash


func _on_body_entered(body: Node2D) -> void:
	splash.play()
