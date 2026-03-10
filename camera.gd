extends Node3D

@export var target:Node3D
@export var offset:Vector3

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	
	# CAMERA POSITION CALCULATIONS
	position = target.position + offset
	# CAMERA POSITION CALCULATIONS

func _input(event: InputEvent) -> void:
	
	# CAMERA ROTATION CALCULATIONS
	if event is InputEventMouseMotion:
		rotation.x -= event.relative.y * .003
		rotation.y -= event.relative.x * .003
	# CAMERA ROTATION CALCULATIONS
