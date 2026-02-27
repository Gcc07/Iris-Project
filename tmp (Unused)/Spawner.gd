extends Control

var spawned_entity
@export var entity : PackedScene = preload("uid://cqxlfhln76dxm")

@onready var button = $TextureButton

func _on_texture_button_pressed() -> void:
	var spawned_entity = entity.instantiate()
	get_parent().get_parent().add_child(spawned_entity)
