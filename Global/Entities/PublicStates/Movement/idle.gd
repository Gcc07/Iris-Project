class_name IdleState
extends MovementState
#
#@export
#var dash_state: State
@export
var fall_state: MovementState
@export
var jump_state: MovementState
@export
var move_state: MovementState

func enter() -> void:
	super()
	parent.velocity.x = 0

func process_input(event: InputEvent) -> MovementState:
	if get_jump() and parent.is_on_floor():
		return jump_state
	if get_movement_input() != 0.0 and parent.can_move:
		return move_state
	return null

func process_physics(delta: float) -> MovementState:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	if get_movement_input() != 0.0 and parent.can_move:
		return move_state
	if !parent.is_on_floor():
		return fall_state
	return null
