class_name SpecialAttackState
extends AttackState

#@export
#var none_state : ActionState

func enter() -> void:
	finished_attack = false
	moveAnimations.active = false
	actionAnimations.active = true
	actionAnimations.play(str(parent.name)+"Action/" + animation_name)

func exit() -> void:
	actionAnimations.active = false

func process_physics(delta: float) -> ActionState:
	if finished_attack:
		return none_state
	else:
		return null


func process(delta: float) -> ActionState:
	return null

func attack_finished():
	finished_attack = true
