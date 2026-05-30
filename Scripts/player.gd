extends CharacterBody3D


var speed = MainConfig.player_speed
var speed_air = MainConfig.player_speed_air
var jump_velocity = MainConfig.player_jump_velocity
var bounce_velocity = MainConfig.player_bounce_velocity
@onready var animated_sprite: AnimatedSprite3D = $AnimatedSprite3D


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
	update_animation(input_dir)
	
func update_animation(input_dir: Vector2) -> void:
	if input_dir == Vector2.ZERO:
		animated_sprite.play("idle")
		return

	# links/rechts stärker als vor/zurück
	if abs(input_dir.x) > abs(input_dir.y):
		if input_dir.x < 0:
			animated_sprite.play("walk_left")
		else:
			animated_sprite.play("walk_right")
	else:
		if input_dir.y < 0:
			animated_sprite.play("walk_down")
		else:
			animated_sprite.play("walk_down")
	
func bounce():
	velocity.y = bounce_velocity

func die():
	GameManager.restart_level()
