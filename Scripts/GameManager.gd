extends Node
var levels := [
	"res://Scenes/Levels/LevelZero/level_Zero.tscn",
	"res://Scenes/Levels/LevelOne/level_one.tscn",
]

var current_level := 0

func restart_level():
	get_tree().change_scene_to_file(levels[current_level])

func next_level():
	if current_level >= levels.size():
		print("Game finished!")
		return
	
	current_level += 1
	print(current_level)
	get_tree().change_scene_to_file(levels[current_level])

#func _process(_delta):
	#if get_tree().get_nodes_in_group("enemy").is_empty():
		#next_level()		
