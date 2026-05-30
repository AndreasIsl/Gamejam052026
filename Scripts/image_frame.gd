extends StaticBody3D

@export var key_id := ''


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_detection_area_body_entered(body: Node3D) -> void:
	print("BODY has entered imageframe Range")
	if  key_id != '' :
		if body.get("item_id") == key_id:
			body.resolve()
			var blockade = get_matching_blockade(key_id)
			if  blockade and blockade.has_method('die'):
				blockade.die()
			ChangeSprite()
	else:
		print("key_id is undefined")


func get_matching_blockade(key_id: String) -> Node:
	for blockade in get_tree().get_nodes_in_group("Blockades"):
		if blockade.get("key_id") == key_id:
			return blockade

	return null


func ChangeSprite() -> void:
	pass # Replace with function body.
