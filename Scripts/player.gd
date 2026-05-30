extends CharacterBody3D


var speed = MainConfig.player_speed
var speed_air = MainConfig.player_speed_air
var jump_velocity = MainConfig.player_jump_velocity
var bounce_velocity = MainConfig.player_bounce_velocity


func _physics_process(delta: float) -> void:
	var current_speed = speed
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		current_speed = speed_air

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
	
func bounce():
	velocity.y = bounce_velocity

func die():
	GameManager.restart_level()
