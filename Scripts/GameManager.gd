extends Node
var levels := [
	#"res://Scenes/Levels/LevelZero/level_Zero.tscn",
	"res://Scenes/Levels/LevelOne/level_one.tscn",
]

var current_level := 0
var collectible_count := 0

signal collectible_count_changed(new_count: int)





func restart_level():
	call_deferred("_restart_level_deferred")


func _restart_level_deferred():
	get_tree().change_scene_to_file(levels[current_level])


func next_level():
	if current_level + 1 >= levels.size():
		print("Game finished!")
		return
	
	current_level += 1
	print(current_level)
	get_tree().change_scene_to_file(levels[current_level])

func _process(_delta):
	pass
		
func collect_collectible():
	collectible_count += 1
	collectible_count_changed.emit(collectible_count)

func reset_collectibles() -> void:
	collectible_count = 0
	collectible_count_changed.emit(collectible_count)
