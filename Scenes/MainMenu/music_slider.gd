extends HSlider

@export var bus_name: String

#@onready var audio_stream_player_2d = $AudioStreamPlayer2D

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	load_game_pref()
	
	value = db_to_linear(
		
		AudioServer.get_bus_volume_db(bus_index)
		
	)
	


func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
		
	)
	
	save_game_pref()


func load_game_pref():
	if FileAccess.file_exists("user://UserMusicPref.data"):
		var file = FileAccess.open("user://UserMusicPref.data", FileAccess.READ)
		value = file.get_var()
		
		file.close()

func save_game_pref():
	var file = FileAccess.open("user://UserMusicPref.data", FileAccess.WRITE)
	file.store_var(value)
	file.close()
