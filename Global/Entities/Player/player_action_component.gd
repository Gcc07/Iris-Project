class_name PlayerActionComponent
extends Node

@export var data_handler_component : DataHandler
# Return a boolean indicating if the character wants to attack

@onready var priority_input_array : Array = []
@onready var input_max_delay = .1 # Seconds
var input_recency_timer = Timer.new()

func _physics_process(delta: float) -> void:
	print(priority_input_array)

func _ready() -> void:
	input_recency_timer.timeout.connect(_on_timer_timeout)
	input_recency_timer.wait_time = input_max_delay  # Set the wait time in seconds
	input_recency_timer.one_shot = true
	add_child(input_recency_timer)

func _on_timer_timeout():
	if priority_input_array.size() > 0:
		priority_input_array.pop_front()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("light_attack"):
		priority_input_array.pop_front()
		priority_input_array.append("light_attack")
		input_recency_timer.start()

	if event.is_action_pressed("special_attack"):
		priority_input_array.pop_front()
		priority_input_array.append("special_attack")
		input_recency_timer.start()
		
	if event.is_action_pressed("heavy_attack"):
		priority_input_array.pop_front()
		priority_input_array.append("heavy_attack")
		input_recency_timer.start()

	if event.is_action_pressed("parry"):
		priority_input_array.pop_front()
		priority_input_array.append("parry")
		input_recency_timer.start()

func get_special_attack_input() -> bool:
	
	if data_handler_component:
		if data_handler_component.parent_entity.resource.amount_of_special_charges > 0:
			if priority_input_array.has("special_attack"):	return true
			return Input.is_action_just_pressed("special_attack")

	else:
		if priority_input_array.has("special_attack"):	return true
		return Input.is_action_just_pressed("special_attack")
	return false


func get_light_attack_input() -> bool:
	if priority_input_array.has("light_attack"):	return true
	return Input.is_action_just_pressed("light_attack")


func get_heavy_attack_input() -> bool:
	if priority_input_array.has("heavy_attack"):	return true
	return Input.is_action_just_pressed("heavy_attack")


func get_parry_input() -> bool:
	if priority_input_array.has("parry"):	return true
	return Input.is_action_just_pressed("parry")
