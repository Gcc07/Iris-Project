class_name Player
extends Entity

@onready
var attack_point = $AttackPoint

@onready
var entity_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready
var move_animations: AnimationPlayer = $MoveAnimationPlayer
@onready
var action_animations: AnimationPlayer = $ActionAnimationPlayer

@onready
var movement_state_machine: Node = $MoveStateMachine
@onready
var action_state_machine: Node = $ActionStateMachine
@onready
var player_move_component = $PlayerMoveComponent
@onready
var player_action_component = $PlayerActionComponent

@onready
var hitbox = $Hitbox

@export 
var resource : PlayerResource


func _ready() -> void:
	movement_state_machine.init(self, entity_sprite, move_animations, action_animations, player_move_component)
	action_state_machine.init(self, entity_sprite, move_animations, action_animations, player_action_component)


func _unhandled_input(event: InputEvent) -> void:

	movement_state_machine.process_input(event)
	action_state_machine.process_input(event)


func _physics_process(delta: float) -> void:

	movement_state_machine.process_physics(delta)
	action_state_machine.process_physics(delta)
	#const_wobble()


func _process(delta: float) -> void:
	# print("Movement: " + move_animations.current_animation, "       Action: " + action_animations.current_animation)
	# print("The attack is: " + attack_state_machine.current_state.name)

	movement_state_machine.process_frame(delta)
	action_state_machine.process_frame(delta)

## ----------------------------------- ##
#func const_wobble():
	#if self.velocity.x <= 80 and self.velocity.x >= -80:
		#player_sprite.rotation = 0
	#elif self.velocity.x >=  100 and player_sprite.rotation < .06:
		#player_sprite.rotation += .01 
	#elif self.velocity.x <= -100 and player_sprite.rotation > -.06:
		#player_sprite.rotation -= .01
