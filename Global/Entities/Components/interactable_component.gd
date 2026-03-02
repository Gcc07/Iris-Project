extends Area2D

signal interaction_cancelled

@export var interact_name : String = ""
@export var is_interactable: bool = true
@export var interact_texture : Control

@export_category("Colors")
@export var border_color_on : Color = Color("ffffffff")
@export var border_color_off : Color = Color("1b1f21")

@export var shade_color_off : Color = Color("2c2c2c92")
@export var shade_color_on: Color = Color("ffffff00")

var interact: Callable = func():
	pass

var end_interaction: Callable = func():
	pass

var perform_on_enter: Callable = func():
	var starting_color : Color = interact_texture.material.get_shader_parameter("shade_color") 
	var starting_color2 : Color = interact_texture.material.get_shader_parameter("outline_color") 
	
	var tween := create_tween()
	tween.tween_method(set_shader_param.bind(self, "shade_color"), starting_color, shade_color_on, .5) # .set_delay(1.0)
	
	var tween2 := create_tween()
	tween2.tween_method(set_shader_param.bind(self, "outline_color"), starting_color2, border_color_on, .5) # .set_delay(1.0)

var perform_on_exit: Callable = func():
	interaction_cancelled.emit()
	
	end_interaction.call()
	
	is_interactable = true
	
	var starting_color : Color = interact_texture.material.get_shader_parameter("shade_color") 
	var starting_color2 : Color = interact_texture.material.get_shader_parameter("outline_color") 
	
	var tween := create_tween()
	tween.tween_method(set_shader_param.bind(self, "shade_color"), starting_color, shade_color_off, .5) # .set_delay(1.0)
	
	var tween2 := create_tween()
	tween2.tween_method(set_shader_param.bind(self, "outline_color"), starting_color2, border_color_off, .5) # .set_delay(1.0)

func set_shader_param(color_value: Color, area : Area2D, parameter_name: String):
	area.interact_texture.material.set_shader_parameter(parameter_name, color_value)
