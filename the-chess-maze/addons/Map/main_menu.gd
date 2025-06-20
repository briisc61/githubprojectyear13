extends Node3D

@onready var camera_pivot: Node3D = $camerapivot
@export var rotation_speed : int = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_pivot.rotation_degrees.y += delta * rotation_speed
