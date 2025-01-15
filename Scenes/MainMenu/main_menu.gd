extends Control

@onready var settings_button = $SettingsButton
@onready var credits_button = $CreditsButton
@onready var start_button = $Start
@onready var quit_button = $Quit
@onready var title = $Title
@onready var settings = $Settings
@onready var window_button = $Settings/WindowButton
@onready var credits_screen = $CreditsScreen
@onready var difficulty = $Difficulty
@onready var difficulty_description = $Difficulty/Description
@onready var click_sound = $ClickSound

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"escape"):
		if difficulty.visible:
			show_beginning()
			difficulty_description.visible = false

func _ready():
	update_display()

func _on_start_pressed() -> void:
	click_sound.play_random()
	hide_beginning()
	difficulty.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_easy_mouse_entered() -> void:
	difficulty_description.text = "3 deeds to consider"
	difficulty_description.visible = true
	click_sound.play_random()

func _on_easy_mouse_exited() -> void:
	difficulty_description.visible = false

func _on_normal_mouse_entered() -> void:
	difficulty_description.text = "5 deeds to consider"
	difficulty_description.visible = true
	click_sound.play_random()

func _on_normal_mouse_exited() -> void:
	difficulty_description.visible = false

func _on_easy_pressed() -> void:
	GameEvents.deed_count = 3
	click_sound.play_random()
	SceneTransion.transion("res://Scenes/Levels/world.tscn")

func _on_normal_pressed() -> void:
	click_sound.play_random()
	GameEvents.deed_count = 5
	SceneTransion.transion("res://Scenes/Levels/world.tscn")

func _on_difficulty_back_pressed() -> void:
	click_sound.play_random()
	show_beginning()
	difficulty.visible = false

func _on_settings_pressed():
	click_sound.play_random()
	hide_beginning()
	settings.visible = true

func update_display():
	window_button.text = "windowed"
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_button.text = "FullScreen"

func _on_button_pressed():
	click_sound.play_random()
	var mode := DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	update_display()

func show_beginning():
	title.visible = true
	start_button.visible = true
	quit_button.visible = true
	credits_button.visible = true
	settings_button.visible = true

func hide_beginning():
	title.visible = false
	start_button.visible = false
	quit_button.visible = false
	credits_button.visible = false
	settings_button.visible = false

func _on_settings_back_pressed():
	show_beginning()
	settings.visible = false
	click_sound.play_random()

func _on_credits_button_pressed() -> void:
	hide_beginning()
	credits_screen.visible = true
	click_sound.play_random()

func _on_credits_back_pressed() -> void:
	click_sound.play_random()
	show_beginning()
	credits_screen.visible = false


func _on_credits_button_mouse_entered():
	click_sound.play_random()


func _on_quit_mouse_entered():
	click_sound.play_random()


func _on_settings_button_mouse_entered():
	click_sound.play_random()


func _on_start_mouse_entered():
	click_sound.play_random()


func _on_difficulty_back_mouse_entered():
	click_sound.play_random()


func _on_window_button_mouse_entered():
	click_sound.play_random()


func _on_settings_back_mouse_entered():
	click_sound.play_random()


func _on_credits_back_mouse_entered():
	click_sound.play_random()


func _on_hard_pressed():
	click_sound.play_random()
	GameEvents.deed_count = 5
	SceneTransion.transion("res://Scenes/Levels/world.tscn")


func _on_hard_mouse_entered():
	difficulty_description.text = "5 deeds to consider + rush hour"
	difficulty_description.visible = true
	click_sound.play_random()


func _on_hard_mouse_exited():
	difficulty_description.visible = false
