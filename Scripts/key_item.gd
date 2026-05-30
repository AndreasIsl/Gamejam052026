extends ThrowableItem

var spawn_transform: Transform3D

func _ready() -> void:
	spawn_transform = global_transform
	original_collision_layer = collision_layer
	original_collision_mask = collision_mask

func die() -> void:
	print("ITEM DIE CALLED")
	call_deferred("respawn")

func respawn() -> void:
	# Physik stoppen
	print("ITEM RESPAWN CALLED")
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	sleeping = true

	# Zurück an Startposition
	global_transform = spawn_transform

	# Falls es gerade getragen wurde
	freeze = false
