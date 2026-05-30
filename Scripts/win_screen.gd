extends Control


func _ready() -> void:
	$VBoxContainer/ReturnButton.pressed.connect(_on_return_pressed)

func _on_return_pressed() -> void:
	GameManager.current_level = 0
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
