class_name EnemyMoveComponent
extends Node

@export var attention_box : Area2D
@export var jump_box : Area2D

# Component that returns information on Enemy movement descisions.
var is_player_in_area : bool = false
var is_player_in_jump_area : bool = false
var player := Player
var target : Entity

func _ready():

	attention_box.connect("body_entered", Callable(self, "_on_notice_box_body_entered"))
	attention_box.connect("body_exited", Callable(self, "_on_notice_box_body_exited"))
	
	jump_box.connect("body_entered", Callable(self, "_on_jump_line_body_entered"))
	jump_box.connect("body_exited", Callable(self, "_on_jump_line_body_entered"))
	
	attention_box.get_child(0).shape.radius = get_parent().AI_notice_radius
	
func _on_notice_box_body_entered(body):
	if body is Player:
		print("Player has entered.")
		attention_box.get_child(0).shape.radius = get_parent().AI_pursue_radius
		is_player_in_area = true
		target = body

func _on_notice_box_body_exited(body):
	if body is Player:
		# var tween = create_tween()
		print("Player has exited.")
		is_player_in_area = false
		target = null
		#tween.tween_property(attention_box.get_child(0).shape, "radius", get_parent().AI_notice_radius, .5) This changes the notice box back to the original through a tween.
		attention_box.get_child(0).shape.radius = get_parent().AI_notice_radius


func _on_jump_line_body_entered(body):
	if body is Player:
		if is_player_in_area == true:
			wants_jump(true)

func _on_jump_line_body_exited(body):
	if body is Player:
		is_player_in_area = false

func get_movement_direction() -> float:
	var direction = Vector2(0,0)
	var velocity_x = 0.0

	if is_player_in_area:
		direction = target.global_position - get_parent().global_position
		velocity_x = snapped(direction.normalized().x,1)
		# print(velocity_x, get_parent().name)
		return velocity_x
	else: 
		velocity_x = 0
		# print(velocity_x, get_parent().name)
		return velocity_x
	
	# Return a boolean indicating if the enemy wants to jump
func wants_jump(y_o_n := false) -> bool:
	return y_o_n
	
