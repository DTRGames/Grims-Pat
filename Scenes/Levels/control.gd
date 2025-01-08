extends CanvasLayer

@onready var label_2 = $%Label2
@onready var label_3 = $%Label3
@onready var label_4 = $%Label4
@onready var animation_player = $AnimationPlayer
@onready var button = $Control/Button
@onready var button_2 = $Control/Button2

var current_crime : Dictionary = {}

# List of crimes with values
var crimes_list = {
	"has commited shoplifting": -2,"stole a banana": -1, "was a victim of magic, Apollo": -1, "has commited vehichular manslaughter": -5,
	"Killed a very big moth": 2, "doesnt smoke": 3, "doesnt drink" : 2, "drug addict": -2, "a very happy fella": 1,
	"has commited tax evasion": -2, "PISSED ON THE MOON": -2, "cyberbullied steve jobs": -2, "likes to walk and talk": 2,
	"built an orphanage": 7, "saved a guy": 5, "filthy rich": -1, "nothing really matters to him": -2, "killed an eldritch god": -3,
	"good boy :3": 2, "a very healthy fella": 4, "saved a bird": 3, "pays his taxes": 2,"is the child of light" : 2, "could never do wrong": 2,
	"solved the fnaf lore": 2, "hes got a cool hat": 1, "weed eater": 2
	
}

# Crimes dictionary
var crimes = {
	1: {
		"name": "Bob",
		"occupation": "Businessman",
		"description": "",
		"is_gulty": false
	},
	2: {
		"name": "Steve",
		"occupation": "Unemployed",
		"description": "",
		"is_gulty": true
	},
	3: {
		"name": "Jay",
		"occupation": "Doctor",
		"description": "",
		"is_gulty": false
	},
	4: {
		"name": "Dude",
		"occupation": "Store Owner",
		"description": "",
		"is_gulty": true
	},
	5: {
		"name": "Guy",
		"occupation": "Doctor",
		"description": "",
		"is_gulty": false
	}
}

var current_crime_id = 0
var last_spawned_id = -1
var wrong_choice = false

# Function to pick random crimes
func pick_random_crimes() -> Dictionary:
	var selected_crimes = []
	var total_value = 0
	for i in range(3):
		var crime = crimes_list.keys()[randi() % crimes_list.size()]
		selected_crimes.append(crime)
		total_value += crimes_list[crime]
	return {"description": ", ".join(selected_crimes), "total_value": total_value}

# Function to assign a random crime
func assign_random_crime() -> int:
	if last_spawned_id != -1:
		crimes.erase(last_spawned_id)
	
	var crime_ids = crimes.keys()
	return crime_ids[randi() % crime_ids.size()]

# Function to process a crime
func process_crime(crime_id: int) -> void:
	var crime = crimes[crime_id]
	var random_crimes = pick_random_crimes()
	crime["description"] = random_crimes["description"]
	crime["is_gulty"] = random_crimes["total_value"] < 0
	label_3.text = str("Occupation: ", crime["occupation"])
	label_2.text = str(crime["name"])
	label_4.text = str("Deeds: ", crime["description"])
	print("Crime description: ", crime["description"])
	print("Total value: ", random_crimes["total_value"])
	print("Is guilty: ", crime["is_gulty"])

# Function to check if a person is a criminal
func is_criminal(crime_id: int) -> bool:
	return crimes[crime_id]["is_gulty"]

func _ready():
	current_crime_id = assign_random_crime()
	process_crime(current_crime_id)

func on_pressed():
	button_2.disabled = true
	button.disabled = true
	
	wrong_choice = is_criminal(current_crime_id)
	if wrong_choice:
		print("Wrong person! This person is innocent.")
	else:
		print("Correct! Score: ")
		GameEvents.on_screen += 1
	
	animation_player.play("Out")
	await animation_player.animation_finished
	GameEvents.leave.emit()
	queue_free()

func on_pressed2():
	button_2.disabled = true
	button.disabled = true
	
	wrong_choice = is_criminal(current_crime_id)
	if wrong_choice:
		print("Correct! Score: ")
		GameEvents.on_screen += 1
	else:
		print("Wrong person! This person is innocent.")
	
	animation_player.play("Out")
	await animation_player.animation_finished
	GameEvents.leave.emit()
	queue_free()

func _on_button_pressed():
	on_pressed()

func _on_button_2_pressed():
	on_pressed()
