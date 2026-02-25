extends Label

var change_max_value_health_value_quotient : float
var lerping : bool
@export_category("Bars")
@export var health_bar : TextureProgressBar
@export var visible_change_bar : TextureProgressBar

func _ready():
	change_max_value_health_value_quotient = visible_change_bar.max_value / health_bar.max_value # This is the 

	on_health_changed(20)
	visible_change_bar.value = health_bar.value * change_max_value_health_value_quotient
	visible_change_bar.visible = true

func on_health_changed(new_health: float):
	health_bar.value = new_health
	change_health_effect(new_health)
	
func change_health_effect(new_health: float):
	visible_change_bar.visible = true
	lerping = true

func _process(delta: float) -> void:
	if !lerping:
		return
	else:
		if visible_change_bar.value- health_bar.value * change_max_value_health_value_quotient  > 1:
			visible_change_bar.value = visible_change_bar.value - 1
		else:
			lerping = false
