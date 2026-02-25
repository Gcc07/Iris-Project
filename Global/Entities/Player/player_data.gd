extends TextureRect

var change_max_value_health_value_quotient : float
var lerping : bool

#func _ready():
	#change_max_value_health_value_quotient = $ChangeEffectBar.max_value / $HealthBar.max_value
#
	#on_health_changed(20)
	#$ChangeEffectBar.value = $HealthBar.value * change_max_value_health_value_quotient
	#$ChangeEffectBar.visible = true
#
#func on_health_changed(new_health: float):
	##text = "Health: " + str(new_health)
#
	#$HealthBar.value = new_health
	#change_health_effect(new_health)
	#
#func change_health_effect(new_health: float):
	#$ChangeEffectBar.visible = true
	#lerping = true
#
#func _process(delta: float) -> void:
	#if !lerping:
		#return
	#else:
		#if $ChangeEffectBar.value- $HealthBar.value * change_max_value_health_value_quotient  > 1:
			#$ChangeEffectBar.value = $ChangeEffectBar.value - 1
		#else:
			#lerping = false
