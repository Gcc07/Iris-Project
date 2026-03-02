extends FallState

@export
var stumble_state: MovementState

@onready var starting_height : float
@onready var to_state : MovementState

func enter() -> void:
	super()
	starting_height = parent.position.y

func process_physics(delta: float) -> MovementState:
	# if ! parent.can_move == false:
		parent.velocity.y += gravity * delta
		var movement = get_movement_input() * move_speed
		parent.velocity.x = movement
		parent.move_and_slide()
		
		if movement != 0:
			sprite.flip_h = movement > 0

		if parent.is_on_floor():
			var current_height : float = parent.position.y
			var MAX_FALL_HEIGHT_BEFORE_STUMBLE: float = 100.0
			
			if -(starting_height - current_height) >= MAX_FALL_HEIGHT_BEFORE_STUMBLE:
				to_state = stumble_state
				return stumble_state
			
			elif (movement != 0):
				return move_state
			
			else:
				return idle_state
		return null
	# return null
	
func exit():
	if (to_state != stumble_state):
		var STEP_1 := 10
		var PITCH_SCALE = .6
		play_extra_sound_with_pitch_scale(STEP_1, PITCH_SCALE)
