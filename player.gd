extends CharacterBody3D

@export var camera:Node3D

var inputDirection:Vector2
var cameraDirection:Vector3

func _physics_process(delta: float) -> void:
	
	# HORIZONTAL MOVE CALCULATIONS
	inputDirection = Vector2(
		Input.get_action_strength("left") - Input.get_action_strength("right"),
		Input.get_action_strength("up") - Input.get_action_strength("down")
		)
	# HORIZONTAL MOVE CALCULATIONS
	
	# CAMERA FORWARD CALCULATIONS
	var forward := -camera.global_transform.basis.z
	var right := camera.global_transform.basis.x
	
	forward.y = 0
	right.y = 0
	forward = forward.normalized()
	right = right.normalized()
	
	cameraDirection = (forward * inputDirection.y + right * inputDirection.x).normalized()
	# CAMERA FORWARD CALCULATIONS
	
	# JUMP CALCULATIONS
	if not is_on_floor():
		velocity = get_gravity()
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = 200
	# JUMP CALCULATIONS
	
	velocity.x = cameraDirection.x * 10
	velocity.z = cameraDirection.z * 10
	
	print(velocity)
	
	move_and_slide()
