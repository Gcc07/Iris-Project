@tool
extends Node2D

var using_pixel_shader : bool = false
var using_entity_debug_texts : bool = true

var correct_scene_is_loaded : Array[int] = [0] # Just a flag, never used as property


func _get_property_list() -> Array:
	var properties: Array = []
	
	properties.append({
		"name" : "using_pixel_shader",
		"type" : TYPE_BOOL,
		"usage" : PROPERTY_USAGE_DEFAULT
	})
	properties.append({
		"name" : "using_entity_debug_texts",
		"type": TYPE_BOOL,
		"usage" : PROPERTY_USAGE_DEFAULT
	})
	return properties
	
