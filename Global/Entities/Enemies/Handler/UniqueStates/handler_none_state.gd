extends EnemyNoneState

@export
var throw_attack_state : ActionState

func enter() -> void:
	super()

func get_throw_attack_input() -> bool:
	return action_component.get_throw_attack_input()

func _on_hitbox_damaged(attack: Attack):
	if attack.stuns == true:
		parent.stunned = true
	print("juicy!")


func process_physics(delta: float) -> ActionState:

	if not parent.alive:
		return death_state
	if parent.stunned:
		return stunned_state
	if get_light_attack_input():
		return light_attack_state
	if get_throw_attack_input():
		return throw_attack_state
	else: 
		return null
