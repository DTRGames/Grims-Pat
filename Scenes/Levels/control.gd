extends CanvasLayer

@onready var label_2 = $%Label2
@onready var label_3 = $%Label3
@onready var label_4 = $%Label4
@onready var animation_player = $AnimationPlayer
@onready var button = $Control/Button
@onready var button_2 = $Control/Button2

var current_crime : Dictionary = {}

var crimes = {
	1: {
		"name": "Bob",
		"occupation": "Businessman",
		"description": "What he did: Stealed from a local store, helped the elders, was in prison for 30 days for killing in self defence",
		"is_gulty": false
	},
	2: {
		"name": "Steve",
		"occupation": "Unemployed",
		"description": "What he did: Suspected for murder, Helped the community",
		"is_gulty": true
	},
	3: {
		"name": "Jay",
		"occupation": "Doctor",
		"description": "What he did: Saved 3 people, stoled 3 gum packets, Committing financial fraud.",
		"is_gulty": false
	}
}

var current_crime_id = 0
var last_spawned_id = -1
var wrong_choice = false

func assign_random_crime() -> int:
	if last_spawned_id != -1:
		crimes.erase(last_spawned_id)
	
	# Get a list of all crime IDs from the crimes dictionary
	var crime_ids = crimes.keys()
	
	# Randomly select a crime from the list
	return crime_ids[randi() % crime_ids.size()]

func process_crime(crime_id: int) -> void:
	# Fetch the assigned crime
	var crime = crimes[crime_id]
	
	
	label_3.text = str("Occupation: ", crime["occupation"])
	label_2.text = str(crime["name"])
	label_4.text = str(crime["description"])

func is_criminal(crime_id: int) -> bool:
	# Check if the crime is medium or high severity
	var crime = crimes[crime_id]
	if crime["is_gulty"] == true:
		return true
	return false

func _ready():
	# Assign a random crime ID
	current_crime_id = assign_random_crime()
	
	# Process the selected crime
	process_crime(current_crime_id)

func on_pressed():
	# If the person is guilty (criminal), increment the score
	button_2.disabled = true
	button.disabled = true
	
	wrong_choice = is_criminal(current_crime_id)
	if wrong_choice:
		
		print("Wrong person! This person is innocent.")
	else:
		GameEvents.on_screen += 1
		print("Correct! Score: ")
	
	
	
	# Play animation and leave the scene
	animation_player.play("Out")
	await animation_player.animation_finished
	GameEvents.leave.emit()
	queue_free()

func on_pressed2():
	# If the person is guilty (criminal), increment the score
	button_2.disabled = true
	button.disabled = true
	
	wrong_choice = is_criminal(current_crime_id)
	if wrong_choice:
		print("Correct! Score: ")
		GameEvents.on_screen += 1
	else:
		print("Wrong person! This person is innocent.")
	
	
	# Play animation and leave the scene
	animation_player.play("Out")
	await animation_player.animation_finished
	GameEvents.leave.emit()
	queue_free()

func _on_button_pressed():
	on_pressed()


func _on_button_2_pressed():
	on_pressed()
