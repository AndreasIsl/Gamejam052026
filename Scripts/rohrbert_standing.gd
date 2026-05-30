extends Enemy

@onready var animation_player: AnimationPlayer = $RohrbertVisual/AnimationPlayer
@onready var visual: Node3D = $RohrbertVisual

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
	move_and_slide()
	update_animation()


func update_animation() -> void:
	if abs(velocity.x) > 0.1:
		play_anim("Armature|Walk")
	else:
		play_anim("Armature|Idle")

func play_anim(anim_name: String) -> void:
	if animation_player.current_animation != anim_name:
		animation_player.play(anim_name)
