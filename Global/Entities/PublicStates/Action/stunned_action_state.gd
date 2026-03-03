class_name StunnedState
extends ActionState

# The State for when an Entity is stunned from an attack.

@export var none_state : ActionState
@export var stun_time : float = .2
@export var is_always_stunned : bool
@export var causes_engine_slowdown : bool

@onready var stun_timer = Timer.new() 

func enter() -> void:
	if causes_engine_slowdown:	set_engine_speed_to(.25)
	
	if not parent.hitbox.is_connected("damaged", _on_hitbox_damaged): # If the hitbox isn't connected,
		parent.hitbox.damaged.connect(_on_hitbox_damaged) # Connect it.
	
	parent.stunned = true
	actionAnimations.play(&"RESET")
	actionAnimations.play(str(parent.entity_id)+"Action/" + animation_name) # Plays the correpsonding animation
	stun_timer.start()
	parent.can_move = !is_always_stunned
	parent.can_be_damaged = false
	actionAnimations.active = true
	moveAnimations.active = false
	sprite.material.set_shader_parameter("shade_color", Color(1.0, 1.0, 1.0))

func _ready(): 
	stun_timer.wait_time = stun_time
	stun_timer.one_shot = true 
	add_child(stun_timer)
	stun_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	parent.stunned = false

func process_physics(delta: float) -> ActionState:
	if not parent.stunned:
		return none_state
	else: 
		return null

func set_engine_speed_to(speed : float):
	Engine.time_scale = speed

func reset_engine_speed():
	Engine.time_scale = 1.0
	
func exit() -> void:
	if causes_engine_slowdown:	reset_engine_speed()
	# actionAnimations.play(&"RESET")
	moveAnimations.active = true
	actionAnimations.active = false
	sprite.material.set_shader_parameter("shade_color", Color(1.0, 1.0, 1.0, 0.0))
	parent.can_be_damaged = true
