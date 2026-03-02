extends Camera2D

# Controls Player Camera Logic.

@export var target : Player
@export var using_pixel_shader : bool
var actual_cam_pos : Vector2
var _subpixel_container: SubViewportContainer

var cutscene_occuring = false
var cutscene_target : Vector2
var cutscene_zoom : Vector2

func _ready() -> void:
	_subpixel_container = get_viewport().get_parent() as SubViewportContainer
	if target:
		actual_cam_pos = target.global_position
		global_position = actual_cam_pos


func _physics_process(delta: float) -> void:
	if (!using_pixel_shader):
		if !cutscene_occuring:
			var BASE_ZOOM = Vector2(1,1)
			zoom = zoom.lerp(BASE_ZOOM, delta * 6)# Base Zoom
			var target_position = target.global_position
			position = position.lerp(target_position, delta * 6 )
			global_position = position
		else:
			zoom = zoom.lerp(cutscene_zoom, delta * 6)
			position = position.lerp(cutscene_target, delta * 6 )
			global_position = position
		
	if using_pixel_shader:
		if !cutscene_occuring:
			var proper_target = Vector2(0,0)
			if target:
				proper_target = Vector2(target.global_position.x , target.global_position.y )
			actual_cam_pos = actual_cam_pos.lerp(proper_target, delta * 6 )
			var cam_subpixel_offset = actual_cam_pos.round() - actual_cam_pos
			_subpixel_container.material.set_shader_parameter("cam_offset", cam_subpixel_offset)
			global_position = actual_cam_pos.round()
			
		else: 
			zoom = zoom.lerp(cutscene_zoom, delta * 6)
			actual_cam_pos = actual_cam_pos.lerp(cutscene_target, delta * 6 )
			var cam_subpixel_offset = actual_cam_pos.round() - actual_cam_pos
			_subpixel_container.material.set_shader_parameter("cam_offset", cam_subpixel_offset)
			global_position = actual_cam_pos.round()

var end_cutscene: Callable = func():
	cutscene_occuring = false

var trigger_cutscene: Callable = func(zoom_amount: Vector2, targets : Array ):
	cutscene_occuring = true
	
	var x_total = 0
	var y_total = 0
	
	for t in targets:
		x_total+= target.global_position.x
		y_total+= target.global_position.y
	
	var x_average = x_total / targets.size()
	var y_average = y_total / targets.size()
	
	cutscene_target = Vector2(x_average,y_average)
	cutscene_zoom = zoom_amount
