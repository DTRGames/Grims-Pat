extends Control

@onready var window_button = $Settings/WindowButton
@onready var settings = $Settings
@onready var settings_button = $SettingsButton
@onready var credits_button = $CreditsButton
@onready var credits_screen = $CreditsScreen

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"escape"):
		if $Difficulty.visible:
			$Difficulty/Description.visible = false
			$Title.visible = true
			$Start.visible = true
			$Quit.visible = true
			credits_button.visible = true
			settings_button.visible = true
			$Difficulty.visible = false
			credits_screen.visible = false

func _ready():
	update_display()

func _on_start_pressed() -> void:
	$Difficulty.visible = true
	settings_button.visible = false
	credits_button.visible = false
	$Title.visible = false
	$Start.visible = false
	$Quit.visible = false
	credits_screen.visible = false

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
	settings_button.visible = true
	credits_button.visible = true
	$Difficulty.visible = false
	credits_screen.visible = false


func _on_settings_pressed():
	$Difficulty/Description.visible = false
	$Title.visible = false
	$Start.visible = false
	$Quit.visible = false
	$Difficulty.visible = false
	settings.visible = true
	settings_button.visible = false
	credits_button.visible = false
	credits_screen.visible = false

func update_display():
	
	window_button.text = "windowed"
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_button.text = "FullScreen"

func _on_button_pressed():
	var mode := DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	
	update_display()


func _on_settings_back_pressed():
	$Difficulty/Description.visible = false
	$Title.visible = true
	$Start.visible = true
	$Quit.visible = true
	credits_button.visible = true
	$Difficulty.visible = false
	settings_button.visible = true
	settings.visible = false
	credits_screen.visible = false


func _on_credits_button_pressed() -> void:
	$Difficulty/Description.visible = false
	$Title.visible = false
	$Start.visible = false
	$Quit.visible = false
	$Difficulty.visible = false
	settings.visible = false
	settings_button.visible = false
	credits_button.visible = false
	credits_screen.visible = true


func _on_credits_back_pressed() -> void:
	$Difficulty/Description.visible = false
	$Title.visible = true
	$Start.visible = true
	$Quit.visible = true
	credits_button.visible = true
	$Difficulty.visible = false
	settings_button.visible = true
	settings.visible = false
	credits_screen.visible = false
