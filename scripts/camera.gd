extends Node3D

@export var target:Node3D
@export var offset:Vector3
@export var pitchLimit:float = deg_to_rad(70)

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	# CAMERA FOLLOW CALCULATIONS
	position = target.position + Vector3(0, offset.y, 0)
	# CAMERA FOLLOW CALCULATIONS
	
	# CAMERA OFFSET CALCULATIONS
	$SpringArm/CameraView.position = $SpringArm/CameraView.position + Vector3(offset.x, 0, offset.z)
	# CAMERA OFFSET CALCULATIONS

func _input(event: InputEvent) -> void:
	
	# CAMERA ROTATION CALCULATIONS
	if event is InputEventMouseMotion:
		rotation.x -= event.relative.y * .003
		rotation.y -= event.relative.x * .003
		
		# ROTATION LIMITS
		rotation.x = clamp(rotation.x, -pitchLimit, pitchLimit)
		# ROTATION LIMITS
		print(rotation)
	# CAMERA ROTATION CALCULATIONS
