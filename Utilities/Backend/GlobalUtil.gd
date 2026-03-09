extends Node

@onready var NORMAL_TIME_SCALE = 1.0

func set_engine_speed_to(speed : float):
	Engine.time_scale = speed

func reset_engine_speed():
	Engine.time_scale = NORMAL_TIME_SCALE
	
func engine_speed_slow_to_normal_transition(starting_speed: float, time):
	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_method(set_engine_speed_to, starting_speed, NORMAL_TIME_SCALE, time)
