extends Label

@export_category("StateMachines")
@export var movement_state_machine : Node2D
@export var action_state_machine : Node2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	text = " \nAction: " + action_state_machine.current_state.name + " \nMove: " + movement_state_machine.current_state.name
