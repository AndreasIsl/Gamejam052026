extends Area3D

@onready var debug_mesh: MeshInstance3D = $DebugMesh

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	debug_mesh.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	print("Hitbox: %s" % body.name)
	print("Has die:", body.has_method("die"))
	if body.has_method("die"):
		body.die()
