class_name ActionState
extends State

# These two are exported because child states will always need acess to them.
@export
var death_state : ActionState
@export
var stunned_state : ActionState
var action_component

func enter() -> void:
	if not parent.hitbox.is_connected("damaged", _on_hitbox_damaged): # If the hitbox isn't connected,
		parent.hitbox.damaged.connect(_on_hitbox_damaged) # Connect it.
	
	actionAnimations.play(str(parent.entity_id)+"Action/" + animation_name) # Plays the correpsonding animation
	

func _on_hitbox_damaged(attack: Attack):
	if attack.stuns == true && parent.can_be_damaged:
		parent.stunned = true

# Pass the inputs from the action components into the sub-states

func get_parry_input() -> bool:
	return action_component.get_parry_input()

func get_light_attack_input() -> bool:
	return action_component.get_light_attack_input()
	
func get_heavy_attack_input() -> bool:
	return action_component.get_heavy_attack_input()

func get_special_attack_input() -> bool:
	return action_component.get_special_attack_input()

func spawn_fx():
	pass
	
