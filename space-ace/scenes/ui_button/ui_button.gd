extends TextureButton


class_name UIButton


@export var text: String


@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = text 	
