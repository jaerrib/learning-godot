extends CharacterBody2D


const SPEED: float = 60.0


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@onready var nav_agent: NavigationAgent2D = $NavAgent


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_just_released("set_target"):
		nav_agent.target_position = get_global_mouse_position()
	update_navigation()
	set_label()


func set_label() -> void:
	var s: String = ""
	s += "done:%s\n" % nav_agent.is_navigation_finished() 
	s += "REACHABLE:%s\n" % nav_agent.is_target_reachable()
	s += "REACHED:%s\n" % nav_agent.is_target_reached()
	s += "TARGET:%s" % nav_agent.target_position
	label.text = s


func update_navigation() -> void:
	if nav_agent.is_navigation_finished() == false:
		var next_path_position: Vector2 =  nav_agent.get_next_path_position()
		sprite_2d.look_at(next_path_position)
		velocity =  global_position.direction_to(next_path_position) * SPEED
		move_and_slide()
