class_name FallState
extends MovementState

@export
var idle_state: MovementState
@export
var move_state: MovementState

func process_physics(delta: float) -> MovementState:
	# if ! parent.can_move == false:
		parent.velocity.y += gravity * delta

		var movement = get_movement_input() * move_speed
		
		if movement != 0:
			sprite.flip_h = movement > 0
		parent.velocity.x = movement
		parent.move_and_slide()
		
		if parent.is_on_floor():
			if movement != 0:
				return move_state
			return idle_state
		return null
	# return null
func exit():
	play_sound()
	pass
	
