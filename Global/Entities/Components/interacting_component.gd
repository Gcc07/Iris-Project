extends Node2D

@onready var interaction_graphic : TextureRect = $InteractionGraphic
var current_interactions = []
var can_interact = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("accept") and can_interact:
		if current_interactions:
			can_interact = false
			interaction_graphic.hide()
			
			await current_interactions[0].interact.call()
			
			can_interact = true
func _process(_delta: float) -> void:
	if current_interactions and can_interact:
		current_interactions.sort_custom(_sort_by_closest) # Similar to a comparator in java
		if current_interactions[0].is_interactable:
			interaction_graphic.show()
	else:
		interaction_graphic.hide()
		
func _sort_by_closest(area1, area2):
	var area1_dist = global_position.distance_to(area1.global_position)
	var area2_dist = global_position.distance_to(area2.global_position)
	return area1_dist < area2_dist # natural sort is smaller -> greatest (i think)

func _on_interactable_area_area_entered(area: Area2D) -> void:
	current_interactions.push_back(area)


func _on_interactable_area_area_exited(area: Area2D) -> void:
	current_interactions.erase(area)
