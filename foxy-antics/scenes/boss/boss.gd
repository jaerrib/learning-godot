extends Node2D


const TRIGGER_CONDITION: String = "parameters/conditions/on_trigger"


@onready var animation_tree: AnimationTree = $AnimationTree


func _on_trigger_area_entered(area: Area2D) -> void:
	animation_tree[TRIGGER_CONDITION] = true
