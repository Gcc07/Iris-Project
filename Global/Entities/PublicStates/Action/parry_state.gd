class_name ParryState
extends ActionState

# The State for when an Entity is parrying

@export var none_state : ActionState
@export var parry_time : float = .2

@onready var parry_timer : Timer

func enter() -> void:
	if not parent.hitbox.is_connected("damaged", _on_hitbox_damaged): # If the hitbox isn't connected,
		parent.hitbox.damaged.connect(_on_hitbox_damaged) # Connect it.
	
	parent.parrying = true
	actionAnimations.play(&"RESET")
	actionAnimations.play(str(parent.entity_id)+"Action/" + animation_name) # Plays the correpsonding animation
	parry_timer.start()
	parent.can_move = true
	parent.can_be_damaged = false
	actionAnimations.active = true
	moveAnimations.active = false

func _ready(): 
	parry_timer = Timer.new() 
	parry_timer.wait_time = parry_time
	parry_timer.one_shot = true 
	add_child(parry_timer)
	parry_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	parent.parrying = false

func process_physics(delta: float) -> ActionState:
	if not parent.parrying:
		return none_state
	else: 
		return null

func exit() -> void:
	parent.parrying = false
	actionAnimations.active = false
