extends Enemy

@onready var animation_player: AnimationPlayer = $RohrbertVisual/AnimationPlayer
@onready var visual: Node3D = $RohrbertVisual

var is_turning := false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0

	if is_turning:
		velocity.x = 0
		velocity.z = 0
		move_and_slide()
		return

	velocity.x = direction * speed
	velocity.z = 0

	if global_position.x > start_x + patrol_distance:
		start_turn(-1)
	elif global_position.x < start_x - patrol_distance:
		start_turn(1)

	update_animation()

	move_and_slide()

func start_turn(new_direction: int) -> void:
	if is_turning:
		return

	if direction == new_direction:
		return

	is_turning = true
	velocity.x = 0
	velocity.z = 0
	
	if new_direction < 0:
		visual.rotation.y = deg_to_rad(-265.0)
	animation_player.play("Armature|Turn")
	await animation_player.animation_finished

	direction = new_direction
	update_rotation()

	is_turning = false

func update_animation() -> void:
	if is_turning:
		return

	if abs(velocity.x) > 0.1:
		play_anim("Armature|Walk")
	else:
		play_anim("Armature|Walk")

func play_anim(anim_name: String) -> void:
	if animation_player.current_animation != anim_name:
		animation_player.play(anim_name)

func update_rotation() -> void:
	if direction > 0:
		visual.rotation.y = deg_to_rad(-65.0)
	else:
		visual.rotation.y = deg_to_rad(-145.0)
		
