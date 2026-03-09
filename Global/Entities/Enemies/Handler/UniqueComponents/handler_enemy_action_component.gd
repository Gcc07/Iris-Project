class_name HandlerActionComponent
extends EnemyActionComponent

@export var throw_attack_detector_area : Area2D
var target_is_in_throw_attack_detector_area : bool = false

func _ready():
	super()
	throw_attack_detector_area.connect("body_entered", Callable(self, "_on_throw_attack_detector_area_body_entered"))
	throw_attack_detector_area.connect("body_exited", Callable(self, "_on_throw_attack_detector_area_body_exited"))

func _on_throw_attack_detector_area_body_entered(body):
	if body is Player:
		# print("Player has entered enemy ranged attack zone.")
		target_is_in_throw_attack_detector_area = true
		target = body

func _on_throw_attack_detector_area_body_exited(body):
	# print("Player has exited the enemy ranged attack zone.")
	target = null
	target_is_in_throw_attack_detector_area = false

func get_throw_attack_input() -> bool:
	return target_is_in_throw_attack_detector_area
