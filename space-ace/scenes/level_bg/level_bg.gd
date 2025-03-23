extends ParallaxBackground


const SPEED: float = 50


@onready var parallax_layer: ParallaxLayer = $ParallaxLayer
@onready var parallax_layer_2: ParallaxLayer = $ParallaxLayer2
@onready var parallax_layer_3: ParallaxLayer = $ParallaxLayer3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	parallax_layer.motion_offset.y += SPEED * delta * 0.2
	parallax_layer_2.motion_offset.y += SPEED * delta * 0.3
	parallax_layer_3.motion_offset.y += SPEED * delta * 0.33
