extends Camera2D

# Controls Player Camera Logic.



@export var target : Player

var actual_cam_pos : Vector2
var _subpixel_container: SubViewportContainer

func _ready() -> void:
	_subpixel_container = get_viewport().get_parent() as SubViewportContainer
	if target:
		actual_cam_pos = target.global_position
		global_position = actual_cam_pos
	
func _physics_process(delta: float) -> void:
	var proper_target = Vector2(0,0)
	if target:
		proper_target = Vector2(target.global_position.x , target.global_position.y )
	actual_cam_pos = actual_cam_pos.lerp(proper_target, delta * 6 )
	var cam_subpixel_offset = actual_cam_pos.round() - actual_cam_pos
	_subpixel_container.material.set_shader_parameter("cam_offset", cam_subpixel_offset)
	global_position = actual_cam_pos.round()


#func _physics_process(delta: float) -> void:
	#var target_position = target.aim_position * sensitivity
	#position = position.lerp(target_position, 0.25)
