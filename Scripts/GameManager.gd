extends Node
var levels := [
	"res://Scenes/Levels/LevelZero/level_Zero.tscn",
	"res://Scenes/Levels/LevelOne/level_one.tscn",
]

var current_level := 0
var can_check_enemies := false



func start_enemy_check():
	can_check_enemies = false

	
	await get_tree().create_timer(1).timeout

	can_check_enemies = true

func restart_level():
	can_check_enemies = false
	call_deferred("_restart_level_deferred")

func _restart_level_deferred():
	get_tree().change_scene_to_file(levels[current_level])

func next_level():
	if current_level >= levels.size():
		print("Game finished!")
		return
	
	current_level += 1
	print(current_level)
	get_tree().change_scene_to_file(levels[current_level])

func _process(_delta):
	if not can_check_enemies:
		return
	
	if get_tree().get_nodes_in_group("Enemies").is_empty():
		next_level()		
