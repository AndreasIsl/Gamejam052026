extends RigidBody3D
class_name ThrowableItem

@export var throw_force = MainConfig.item_throw_force
@export var throw_up_force = MainConfig.item_up_force

@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var pickup_area: Area3D = $PickupRange

var original_parent: Node
var original_collision_layer: int
var original_collision_mask: int
var is_held := false


func _ready() -> void:
	original_collision_layer = collision_layer
	original_collision_mask = collision_mask


func pickup(carry_point: Node3D) -> void:
	is_held = true
	original_parent = get_parent()

	freeze = true
	sleeping = true
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO

	collision_layer = 0
	collision_mask = 0
	collision_shape.disabled = true
	pickup_area.monitoring = false


	var old_global_transform := global_transform

	get_parent().remove_child(self)
	carry_point.add_child(self)

	global_transform = carry_point.global_transform
	position = Vector3.ZERO
	rotation = Vector3.ZERO


func throw(direction: Vector3) -> void:
	is_held = false

	var old_global_transform := global_transform
	var target_parent := original_parent if is_instance_valid(original_parent) else get_tree().current_scene

	get_parent().remove_child(self)
	target_parent.add_child(self)

	global_transform = old_global_transform

	collision_layer = original_collision_layer
	collision_mask = original_collision_mask
	collision_shape.disabled = false
	pickup_area.monitoring = true

	freeze = false
	sleeping = false
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO

	var impulse = direction.normalized() * throw_force
	impulse.y += throw_up_force

	apply_central_impulse(impulse)



func _on_pickup_range_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") and body.has_method("set_nearby_item"):
		body.set_nearby_item(self)


func _on_pickup_range_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player") and body.has_method("clear_nearby_item"):
		body.clear_nearby_item(self)	
