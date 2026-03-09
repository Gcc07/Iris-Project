## Generally used for correspondence with UI. Currently only used in player, maybe will adapt it for all entities.
class_name DataHandler
extends Node

signal special_used(available_number_of_uses : int)
signal special_upgraded(new_number_of_uses : int)

@export var special_attack_state : AttackState
@onready var parent_entity : Entity = get_owner()

func _ready():
	if special_attack_state:
		special_attack_state.special_attack.connect(_on_special_used)
	special_upgraded.emit(parent_entity.resource.amount_of_special_charges)
	special_used.emit(parent_entity.resource.amount_of_special_charges)

func _on_special_used():
	print("going through _on_special_used inside data handler")
	if parent_entity.resource.amount_of_special_charges > 0:
		parent_entity.resource.amount_of_special_charges -= 1

	special_used.emit(parent_entity.resource.amount_of_special_charges) # emit for UI to switch

func _update_max_number_of_special_uses(change_by_amount: int):
	parent_entity.resource.max_amount_of_special_charges += change_by_amount # Changes max number of specials by specified amount
	special_upgraded.emit(parent_entity.resource.max_amount_of_special_charges) # Emits the upgraded number for UI

func _process(delta: float) -> void:
	if parent_entity.just_successfully_parried:
		if parent_entity.resource.max_amount_of_special_charges != parent_entity.resource.amount_of_special_charges: # if (player) num of charges doesn't equal their max allotted amount
			parent_entity.resource.amount_of_special_charges += 1 # Add a charge because they just parried
			parent_entity.just_successfully_parried = false # Switch just parried flag (to off)
			special_used.emit(parent_entity.resource.amount_of_special_charges)
