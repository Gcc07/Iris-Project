extends Label

@export_category("StateMachines")
@export var movement_state_machine : Node2D
@export var action_state_machine : Node2D
@export var AnimatedSprite : AnimatedSprite2D

func _process(delta: float) -> void:
	visible = Settings.using_entity_debug_texts
	var frame = str(AnimatedSprite.frame)
	var velocity = str(get_parent().velocity)
	text = " \nAction: " + action_state_machine.current_state.name + " \nMove: " + movement_state_machine.current_state.name + " \nSprite State: " + AnimatedSprite.animation + " : " + frame + "\nVelocity: " + velocity 
