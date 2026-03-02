extends Node2D

@onready var interaction_graphic : TextureRect = $InteractionGraphic
var current_interactions = [] # Stores all interactables within a certain radius
var can_interact = true

func _input(event: InputEvent) -> void: # Input event for if input is pressed
	if event.is_action_pressed("accept") and can_interact:
		if current_interactions:
			can_interact = false
			interaction_graphic.hide()
			
			await current_interactions[0].interact.call() # Get first interactable in list, call its interact function, await for it to finish
			can_interact = true
			

func _process(_delta: float) -> void:
	var priority_interactable : Area2D
	if current_interactions and can_interact:
		current_interactions.sort_custom(_sort_by_closest) # Similar to a comparator in java, used to sort by closest
		priority_interactable = current_interactions[0]
		if priority_interactable.is_interactable:
			interaction_graphic.show()
	else:
		interaction_graphic.hide()
		
func _sort_by_closest(area1, area2):
	var area1_dist = global_position.distance_to(area1.global_position)
	var area2_dist = global_position.distance_to(area2.global_position)
	return area1_dist < area2_dist # natural sort is smaller -> greatest (i think)

	
func _on_interactable_area_area_entered(area: Area2D) -> void:
	area.perform_on_enter.call()
	current_interactions.push_back(area)


func _on_interactable_area_area_exited(area: Area2D) -> void:
	area.perform_on_exit.call()
	current_interactions.erase(area)
