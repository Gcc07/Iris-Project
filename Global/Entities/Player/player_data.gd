extends TextureRect

@export
var healthBar : TextureProgressBar
@export
var specialContainers : VBoxContainer
@export
var specialOrbs: VBoxContainer


func _ready():
	healthBar.visible = true
	var player = get_tree().get_first_node_in_group("player")
	
	if player:
		
		# Health bar logic
		var health_component : Health = player.get_node("HealthComponent") # Get player's health component
		health_component.health_changed.connect(_on_health_changed) # Connect it to callable
		healthBar.max_value = health_component.max_health # Set the health bar node's max value to the max player health
		_on_health_changed(health_component.max_health) # Set the health to the max health
		
		# Special Attack Container Logic
		var data_component : DataHandler = player.get_node("DataHandlerComponent")
		data_component.special_upgraded.connect(_update_number_of_containers)
		data_component.special_used.connect(_update_number_of_orbs)
		_update_number_of_orbs(data_component.parent_entity.resource.amount_of_special_charges)
		_update_number_of_containers(data_component.parent_entity.resource.max_amount_of_special_charges)


func _on_health_changed(new_health: float):
	healthBar.value = new_health
	change_health_effects(new_health)

func change_health_effects(new_health: float):
	healthBar.visible = true


func _update_number_of_containers(new_max : int):
	specialContainers.size.x = 11 * new_max

func _update_number_of_orbs(new_amount : int):
	print("Finally, reached UI")
	
	specialOrbs.size.x = 11 * new_amount
	if new_amount == 0:		specialOrbs.visible = false
	else: 	specialOrbs.visible = true
