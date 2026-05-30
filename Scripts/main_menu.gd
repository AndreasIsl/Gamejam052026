extends Control

@export var first_level_path := "res://Scenes/Levels/LevelZero/level_Zero.tscn"

func _ready() -> void:
	$VBoxContainer/PlayButton.pressed.connect(_on_play_pressed)
	$VBoxContainer/ExitButton.pressed.connect(_on_exit_pressed)

func _on_play_pressed() -> void:
	GameManager.current_level = 0
	get_tree().change_scene_to_file(GameManager.levels[GameManager.current_level])

func _on_exit_pressed() -> void:
	get_tree().quit()
