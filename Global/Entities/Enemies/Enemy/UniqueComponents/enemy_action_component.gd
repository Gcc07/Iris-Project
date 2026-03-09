class_name EnemyActionComponent
extends Node

@export var attack_detector_area : Area2D
var target_is_in_attack_detector_area : bool = false
var target : Entity

func _ready():

	attack_detector_area.connect("body_entered", Callable(self, "_on_attack_detector_area_body_entered"))
	attack_detector_area.connect("body_exited", Callable(self, "_on_attack_detector_area_body_exited"))
	
func _on_attack_detector_area_body_entered(body):
	if body is Player:
		# print("Player has entered enemy attack zone.")
		target_is_in_attack_detector_area = true
		target = body
	
func _on_attack_detector_area_body_exited(body):
	# print("Player has exited the enemy attack zone.")
	target = null
	target_is_in_attack_detector_area = false

# Handle basic attack inputs for enemy.
	
func get_light_attack_input() -> bool:
	return target_is_in_attack_detector_area

func get_heavy_attack_input() -> bool:
	return false

func get_special_attack_input() -> bool:
	return false
	
func _physics_process(delta: float) -> void:
	if get_parent().enemy_sprite.flip_h == true:
		for i in get_parent().get_children():
			if i is Area2D:
				i.scale.x = -1

		#attack_box.scale.x = -1
	if get_parent().enemy_sprite.flip_h == false:
		for i in get_parent().get_children():
			if i is Area2D:
				i.scale.x = 1
		#attack_box.scale.x = 1
