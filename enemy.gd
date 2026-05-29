extends CharacterBody3D




func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	move_and_slide()


func _on_head_area_body_entered(body: Node3D) -> void:
	print(body.name)
	if body.is_in_group("Player"):
		print('Body is in Group')
		if body.global_position.y > global_position.y:
			print('should work')
			body.bounce()
			queue_free()
