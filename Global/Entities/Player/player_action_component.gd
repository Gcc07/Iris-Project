class_name PlayerActionComponent
extends Node

@export var data_handler_component : DataHandler
# Return a boolean indicating if the character wants to attack

func get_special_attack_input() -> bool:
	if data_handler_component:
		if data_handler_component.parent_entity.resource.amount_of_special_charges > 0:
			return Input.is_action_just_pressed("special_attack")
	return false
	
func get_light_attack_input() -> bool:
	return Input.is_action_just_pressed("light_attack")
	
func get_heavy_attack_input() -> bool:
	return Input.is_action_just_pressed("heavy_attack")

func get_parry_input() -> bool:
	return Input.is_action_just_pressed("parry")
