extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"escape"):
		if $Difficulty.visible:
			$Difficulty/Description.visible = false
			$Title.visible = true
			$Start.visible = true
			$Quit.visible = true
			$Difficulty.visible = false

func _on_start_pressed() -> void:
	$Difficulty.visible = true
	$Title.visible = false
	$Start.visible = false
	$Quit.visible = false

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_easy_mouse_entered() -> void:
	$Difficulty/Description.text = "3 deeds to consider"
	$Difficulty/Description.visible = true

func _on_easy_mouse_exited() -> void:
	$Difficulty/Description.visible = false

func _on_normal_mouse_entered() -> void:
	$Difficulty/Description.text = "5 deeds to consider"
	$Difficulty/Description.visible = true

func _on_normal_mouse_exited() -> void:
	$Difficulty/Description.visible = false

func _on_easy_pressed() -> void:
	GameEvents.deed_count = 3
	SceneTransion.transion("res://Scenes/Levels/world.tscn")

func _on_normal_pressed() -> void:
	GameEvents.deed_count = 5
	SceneTransion.transion("res://Scenes/Levels/world.tscn")

func _on_back_pressed() -> void:
	$Difficulty/Description.visible = false
	$Title.visible = true
	$Start.visible = true
	$Quit.visible = true
	$Difficulty.visible = false
