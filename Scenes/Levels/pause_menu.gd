extends Control


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"escape"):
		if visible:
			visible = false
		else :
			visible = true

func _on_resume_pressed() -> void:
	visible = false

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/world.tscn")

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")
