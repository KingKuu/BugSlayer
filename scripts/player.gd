extends CharacterBody3D

@export var camera:Node3D

var inputDirection:Vector2
var moveDirection:Vector3
var dashDirection:Vector3

func _physics_process(delta: float) -> void:
	
	# HORIZONTAL MOVE INPUT CALCULATIONS
	inputDirection = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
		)
	# HORIZONTAL MOVE INPUT CALCULATIONS
	
	# ROTATE CHARACTER TO FACE AWAY FROM CAMERA
	rotation.y = camera.rotation.y
	# ROTATE CHARACTER TO FACE AWAY FROM CAMERA
	
	# MAKE PLAYER MOVE FORWARD BASED ON ROTATION
	moveDirection = (transform.basis * Vector3(inputDirection.x, 0, inputDirection.y)).normalized()
	# MAKE PLAYER MOVE FORWARD BASED ON ROTATION
	
	# DASH TIMER
	if Input.is_action_just_pressed("dash") and $DashCooldown.time_left == 0:
		$DashTimer.start()
		$DashCooldown.start()
	# DASH TIMER
	
	# FORGIVENESS TIMERS
	if is_on_floor():
		$CoyoteTimer.start()
	
	if Input.is_action_just_pressed("jump"):
		$JumpBufferTimer.start()
	# FORGIVENESS TIMERS
	
	# GRAVITY CALCULATIONS
	if not is_on_floor():
		# FALLING
		if velocity.y < 0:
			velocity += get_gravity() * 3.5 * delta
		# FALLING
		# VARIABLE JUMP HEIGHT
		elif velocity.y > 0 and not Input.is_action_pressed("jump"):
			velocity += get_gravity() * 4.0 * delta
		# VARIABLE JUMP HEIGHT
		# STANDARD GRAVITY
		else:
			velocity += get_gravity() * delta
		# STANDARD GRAVITY
	# GRAVITY CALCULATIONS
	
	# JUMP CALCULATIONS
	if $JumpBufferTimer.time_left > 0 and $CoyoteTimer.time_left >  0:
		velocity.y = 10.0
		$JumpBufferTimer.stop()
		$CoyoteTimer.stop()
	# JUMP CALCULATIONS
	
	# FOOTSTEPS
	if (velocity.x != 0 or velocity.z != 0) and is_on_floor():
		if not $StepAudio.playing:
			$StepAudio.play()
	# FOOTSTEPS
	
	# FINAL VELOCITY CALCULATIONS
	if $DashTimer.time_left > 0:
		velocity.x = lerp(velocity.x, moveDirection.x * 30.0, 0.5)
		velocity.z = lerp(velocity.z, moveDirection.z * 30.0, 0.5)
	else:
		if is_on_floor():
			velocity.x = lerp(velocity.x, moveDirection.x * 10.0, 0.2)
			velocity.z = lerp(velocity.z, moveDirection.z * 10.0, 0.2)
		else:
			velocity.x = lerp(velocity.x, moveDirection.x * 10.0, 0.02)
			velocity.z = lerp(velocity.z, moveDirection.z * 10.0, 0.02)
	# FINAL VELOCITY CALCULATIONS
	
	move_and_slide()
