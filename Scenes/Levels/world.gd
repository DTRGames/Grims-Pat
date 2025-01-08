extends Node2D

var instance = preload("res://Scenes/Levels/control.tscn")
var last_spawned_id = -1
@onready var control = $Control

func _process(delta):
	if GameEvents.on_screen == randf_range(10, 15):
		get_tree().change_scene_to_file("res://Globals/game_events.tscn")

func _ready():
	GameEvents.leave.connect(on_leave)
	last_spawned_id = control.current_crime_id

func on_leave():
	var ins = instance.instantiate()
	control = ins
	
	if last_spawned_id != -1:
		control.last_spawned_id = last_spawned_id
	
	add_child(ins)
	last_spawned_id = control.current_crime_id
