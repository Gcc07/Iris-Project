class_name NPC
extends Entity

@onready var talking = true

@export
var entity_sprite : AnimatedSprite2D # = 
@export
var move_animations: AnimationPlayer # = $MoveAnimationPlayer
@export
var action_animations: AnimationPlayer # = $ActionAnimationPlayer

@export
var movement_state_machine: Node # = $MoveStateMachine
@export
var action_state_machine: Node # = $ActionStateMachine
@export
var move_component : Node # = $EnemyMoveComponent
@export
var action_component : Node # = $EnemyActionComponent

@export
var interactable_component : Node # = $EnemyActionComponent 

@export_group("NPC AI Properties")
@export
var AI_notice_radius := 60.0
@export 
var AI_pursue_radius := 100.0


func _ready() -> void:
	interactable_component.interact = _interact # Overridden interact within interactable component
	interactable_component.end_interaction = _end_interaction
	
	if movement_state_machine:		movement_state_machine.init(self, entity_sprite, move_animations, action_animations, move_component)
	if action_state_machine:		action_state_machine.init(self, entity_sprite, move_animations, action_animations, action_component)

## Method from interactable
func _interact(): 
	interactable_component.is_interactable = false
	
	# Cutscene Effect
	var camera = get_viewport().get_camera_2d()
	var ZOOM_AMOUNT = Vector2(1.5,1.5)
	var targets : Array = [self, get_tree().get_nodes_in_group("Player")]
	camera.trigger_cutscene.call(ZOOM_AMOUNT, targets)

	var interaction_cancelled : Array[bool] = [false] # This is a flag. (Its an array so its mutable by the lambda function)
	## This lambda just makes it so if it recieves the early cancel call from the interactable, the interaction will end.
	interactable_component.interaction_cancelled.connect( 
		func():
		interaction_cancelled[0] = true,
		CONNECT_ONE_SHOT
	)

	while ! Input.is_action_just_pressed("escape") && ! interaction_cancelled[0]:
		await get_tree().process_frame #
	
	if Input.is_action_just_pressed("escape"):
		print("Escaped")
	if interaction_cancelled[0]:
		print("Walked Away")
	
	_end_interaction()
	interactable_component.is_interactable = true
	

	
	#TODO Dialogue system

## Method from interactable
func _end_interaction():
	
	var camera = get_viewport().get_camera_2d()
	camera.end_cutscene.call()

func _unhandled_input(event: InputEvent) -> void:
	
	if movement_state_machine:		movement_state_machine.process_input(event)
	if action_state_machine:		action_state_machine.process_input(event)


func _physics_process(delta: float) -> void:

	if movement_state_machine:		movement_state_machine.process_physics(delta)
	if action_state_machine:		action_state_machine.process_physics(delta)


func _process(delta: float) -> void:

	if movement_state_machine:		movement_state_machine.process_frame(delta)
	if action_state_machine:		action_state_machine.process_frame(delta)
