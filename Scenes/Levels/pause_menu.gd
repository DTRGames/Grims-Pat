extends Control

var stop : bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"escape") and stop == false:
		if visible:
			visible = false
		else :
			visible = true

func _on_resume_pressed() -> void:
	visible = false

func _on_restart_pressed() -> void:
	SceneTransion.transion("res://Scenes/Levels/world.tscn")

func _on_main_menu_pressed() -> void:
	SceneTransion.transion("res://Scenes/MainMenu/main_menu.tscn")
