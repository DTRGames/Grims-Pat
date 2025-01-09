extends Control

var stop : bool = false

@onready var v_box_container = $Panel/VBoxContainer

@onready var window_button = $Settings/WindowButton
@onready var settings_back = $Settings/SettingsBack
@onready var label = $Settings/Label
@onready var settings = $Settings
@onready var title = $Panel/Title

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"escape") and stop == false:
		if visible:
			visible = false
		else :
			visible = true

func update_display():
	
	window_button.text = "windowed"
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_button.text = "FullScreen"

func _on_resume_pressed() -> void:
	visible = false

func _on_restart_pressed() -> void:
	SceneTransion.transion("res://Scenes/Levels/world.tscn")

func _on_main_menu_pressed() -> void:
	SceneTransion.transion("res://Scenes/MainMenu/main_menu.tscn")


func _on_window_button_pressed():
	var mode := DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	
	update_display()


func _on_settings_back_pressed():
	v_box_container.visible = true
	title.visible = true
	window_button.visible = false
	label.visible = false
	settings_back.visible = false
	settings.visible = false


func _on_settings_pressed():
	v_box_container.visible = false
	window_button.visible = true
	label.visible = true
	title.visible = false
	settings_back.visible = true
	settings.visible = true
