class_name State
extends Node

@export
var state_sound : SoundEffect.SOUND_EFFECT_TYPE
@export var animation_name: String
@export var priority: int = 0
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

## The sprite of the entity
var sprite: AnimatedSprite2D
## The move animation player of the entity
var moveAnimations: AnimationPlayer
## The action animation player of the entity
var actionAnimations: AnimationPlayer
# var move_component - IN MOVEMENT STATE
# var attack_component - IN ACTION STATE
## Refers to the parent entity
var parent: CharacterBody2D ## So things that aren't just the player can use the state machine. (all entities)

## Sound methods
# Extra = non state assigned sound
# State = sound assigned to state

func play_state_sound() -> void:
	AudioManager.create_audio(state_sound)
	
func play_sound_extra(extra: SoundEffect.SOUND_EFFECT_TYPE) -> void:
	AudioManager.create_audio(extra)
	
func play_extra_sound_with_pitch_scale(extra: SoundEffect.SOUND_EFFECT_TYPE, pitch_scale: float) -> void:
	AudioManager.create_audio_with_pitch_scale(extra, pitch_scale)

# Base state methods

func enter() -> void:
	pass 
	
func exit() -> void:
	pass

func process(_delta: float) -> State:
	return null

func process_input(delta: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
