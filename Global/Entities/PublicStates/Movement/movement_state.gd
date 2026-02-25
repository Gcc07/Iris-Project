class_name MovementState
extends State

var move_component

@export var move_speed: float = 150

func enter() -> void:
	moveAnimations.play(str(parent.entity_id)+"Move/" + animation_name)
	

func get_movement_input() -> float:
	if parent.can_move:
		return move_component.get_movement_direction()
	return 0.0

func get_jump() -> bool:
	return move_component.wants_jump()
