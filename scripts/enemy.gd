extends CharacterBody3D

var target:Vector3

func _process(delta: float) -> void:
	for p in get_tree().current_scene.get_children():
		if p.is_in_group("player"):
			target = p.global_position

func _physics_process(delta: float) -> void:
	
	if target != Vector3.ZERO:
		velocity.x = lerp(velocity.x, (target.x - global_position.x) * 2, 0.01)
		velocity.z = lerp(velocity.z, (target.z - global_position.z) * 2, 0.01)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.5)
		velocity.z = lerp(velocity.z, 0.0, 0.5)
	
	velocity += get_gravity() * delta
	
	move_and_slide()
