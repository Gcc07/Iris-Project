class_name NoneState
extends ActionState

# The State for when an Entity has no current actions.
@export_group("Attack States")
@export
var light_attack_state : ActionState
@export
var heavy_attack_state : ActionState
@export
var special_attack_state : ActionState

@export_group("Action States")
@export
var parry_state : ActionState

func enter() -> void:
	moveAnimations.play(&"RESET") ## CAUSES WEIRD ISSUE WHERE ATTACK PLAYS TWICE
	# I don't like it, (because its a direct call on the move animations, 
	# but i guess thats why i gave both state machines access to each other...)
	moveAnimations.play_section(str(parent.entity_id) + "Move/" + parent.movement_state_machine.current_state.animation_name)
	
	parent.can_move = true
	actionAnimations.active = false
	moveAnimations.active = true

func _on_hitbox_damaged(attack: Attack):
	if attack.stuns == true:
		parent.stunned = true

func process_physics(delta: float) -> ActionState:
	if parent.stunned:
		return stunned_state
	if not parent.alive:
		return death_state
	if get_special_attack_input():
		return special_attack_state
	if get_light_attack_input():
		return light_attack_state
	if get_heavy_attack_input():
		if parent.is_on_floor():
			return heavy_attack_state
	if get_parry_input():
		return parry_state
	return null
