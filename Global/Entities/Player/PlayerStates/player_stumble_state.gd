extends MovementState

@export
var fall_state: MovementState
@export
var idle_state: MovementState
@export
var move_state: MovementState

@onready var stumble_finished: bool = false # Flag

func enter() -> void:
	super()
	var STEP_1 := 11
	var PITCH_SCALE = .7
	play_extra_sound_with_pitch_scale(STEP_1, PITCH_SCALE)

func finish_stumble() -> void:
	stumble_finished = !stumble_finished

func process_physics(delta: float) -> MovementState:

	parent.velocity.y += gravity * delta
	var movement = get_movement_input() * move_speed # * entity_applied_speed_effects
	parent.velocity.x = movement
	if movement != 0:
		sprite.flip_h = movement > 0
	parent.move_and_slide()
	print(stumble_finished)
	if (stumble_finished):
		if movement == 0 || ! parent.can_move:
			return idle_state
		else: # If you can move AND you are moving.
			return move_state

	if (! parent.is_on_floor()):
		return fall_state
	return null

func exit() -> void:
	stumble_finished = false


	
