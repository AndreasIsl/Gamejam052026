extends CharacterBody3D

class_name Enemy


var speed = MainConfig.enemy_speed
var gravity = MainConfig.enemy_gravity
@export var patrol_distance = MainConfig.patrol_distance


var direction := 1
var start_x := 0.0

@onready var sprite: Sprite3D = $Sprite3D


func _ready():
	start_x = global_position.x

func _physics_process(delta):
	# Gravitation
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0

	# Links/rechts laufen
	velocity.x = direction * speed
	velocity.z = 0

	# Wenn zu weit rechts/links, Richtung wechseln
	if global_position.x > start_x + patrol_distance:
		direction = -1
	elif global_position.x < start_x - patrol_distance:
		direction = 1

	# Sprite spiegeln
	sprite.flip_h = direction < 0

	move_and_slide()


func _on_hitbox_body_entered(body: Node3D) -> void:
	print("Hitbox: %s" % body.name)
	if body.is_in_group("Player"):
		body.die()


func _on_head_area_area_entered(area: Area3D) -> void:
	if area.is_in_group("PlayerFeet"):
		print("HeadArea: %s" % area.name)
		var player = area.get_parent()

		if player.has_method("bounce"):
			player.bounce()

		die()

func die() -> void:
	call_deferred("queue_free")
