extends ColorRect

@onready var count = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	material.set("shader_parameter/brightness",10)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	count *= 1.00001
	
	material.set("shader_parameter/brightness",count)
	material.set("shader_parameter/time_scale",count)
