extends TextureRect

@export
var healthBar : TextureProgressBar
func _ready():
	healthBar.visible = true
	
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var health_component : Health = player.get_node("HealthComponent") # Get player in tree
		health_component.health_changed.connect(on_health_changed) # Get player health component
		
		healthBar.max_value = health_component.max_health # Set the health bar node's max value to the max player health
		on_health_changed(health_component.max_health) # Set the health to the max health

func on_health_changed(new_health: float):
	healthBar.value = new_health
	change_health_effect(new_health)
	
func change_health_effect(new_health: float):
	healthBar.visible = true
