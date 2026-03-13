extends CharacterBody3D

@export var camera:Node3D

var inputDirection:Vector2
var moveDirection:Vector3

func _physics_process(delta: float) -> void:
	
	# HORIZONTAL MOVE CALCULATIONS
	inputDirection = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
		)
	# HORIZONTAL MOVE CALCULATIONS
	
	# ROTATE CHARACTER TO FACE AWAY FROM CAMERA
	rotation.y = camera.rotation.y
	# ROTATE CHARACTER TO FACE AWAY FROM CAMERA
	
	# MAKE PLAYER MOVE FORWARD BASED ON ROTATION
	moveDirection = (transform.basis * Vector3(inputDirection.x, 0, inputDirection.y)).normalized()
	# MAKE PLAYER MOVE FORWARD BASED ON ROTATION
	
	# GRAVITY CALCULATIONS
	if not is_on_floor():
		velocity += get_gravity()
	# GRAVITY CALCULATIONS
	
	# JUMP CALCULATIONS
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 100
	if Input.is_action_just_released("jump") and velocity.y > 0:
		velocity.y = velocity.y * 0.5
	# JUMP CALCULATIONS
	
	# FOOTSTEPS
	if velocity.x or velocity.z:
		$StepAudio.play()
	# FOOTSTEPS
	
	velocity.x = moveDirection.x * 10
	velocity.z = moveDirection.z * 10
	
	move_and_slide()
