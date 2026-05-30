extends CharacterBody3D


var speed = MainConfig.player_speed
var speed_air = MainConfig.player_speed_air
var jump_velocity = MainConfig.player_jump_velocity
var bounce_velocity = MainConfig.player_bounce_velocity

@onready var animated_sprite: AnimatedSprite3D = $AnimatedSprite3D
@onready var carry_point: Node3D = $CarryNode

var nearby_item: ThrowableItem = null
var carried_item: ThrowableItem = null
var facing_direction := Vector3.FORWARD


func _ready() -> void:
	axis_lock_linear_z = true


func _physics_process(delta: float) -> void:
	var current_speed = speed

	if not is_on_floor():
		velocity += get_gravity() * delta
		current_speed = speed_air

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction != Vector3.ZERO:
		facing_direction = direction
		
	if direction:
		velocity.x = direction.x * current_speed
		#velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		#velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
	update_animation(input_dir)
	
	if Input.is_action_just_pressed("interact"):
		if carried_item == null and nearby_item != null:
			pickup_item(nearby_item)

	if Input.is_action_just_pressed("throw"):
		if carried_item != null:
			throw_item()
	
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
	#else:
		#if input_dir.y < 0:
			#animated_sprite.play("walk_down")
		#else:
			#animated_sprite.play("walk_down")
	
func bounce():
	velocity.y = bounce_velocity

func die():
	GameManager.restart_level()

func set_nearby_item(item: ThrowableItem) -> void:
	if carried_item == null:
		nearby_item = item

func clear_nearby_item(item: ThrowableItem) -> void:
	if nearby_item == item:
		nearby_item = null

func pickup_item(item: ThrowableItem) -> void:
	carried_item = item
	nearby_item = null
	item.pickup(carry_point)

func throw_item() -> void:
	var item := carried_item
	carried_item = null

	item.throw(facing_direction)
	
