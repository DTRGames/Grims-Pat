extends Node2D

var instance = preload("res://Scenes/Levels/control.tscn")

func _process(delta):
	if GameEvents.on_screen == randf_range(10, 15):
		get_tree().change_scene_to_file("res://Globals/game_events.tscn")

func _ready():
	GameEvents.leave.connect(on_leave)

func on_leave():
	var ins = instance.instantiate()
	add_child(ins)
