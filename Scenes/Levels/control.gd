extends CanvasLayer

@onready var label_2 = $%Label2
@onready var label_3 = $%Label3
@onready var label_4 = $%Label4
@onready var animation_player = $AnimationPlayer
@onready var button = $Control/Button
@onready var button_2 = $Control/Button2

var current_deed : Dictionary = {}

# List of deeds with values
var deed_list = {
	"has did shoplifting": -2,"stole a banana": -1, "was a victim of magic, Apollo": -1, "has did vehichular manslaughter": -5,
	"Killed a very big moth": 2, "doesnt smoke": 3, "doesnt drink" : 2, "drug addict": -2, "a very happy fella": 1,
	"has did tax evasion": -2, "PISSED ON THE MOON": -2, "cyberbullied steve jobs": -2, "likes to walk and talk": 2,
	"built an orphanage": 7, "saved a guy": 5, "filthy rich": -1, "nothing really matters to him": -2, "killed an eldritch god": -3,
	"good boy :3": 2, "a very healthy fella": 4, "saved a bird": 3, "pays his taxes": 2,"is the child of light" : 2, "could never do wrong": 2,
	"solved the fnaf lore": 2, "hes got a cool hat": 1, "weed eater": 2, "put some dirt in your eyes": 0
}

# deeds dictionary
var deeds = {
	1: {
		"name": "Bob",
		"occupation": "Businessman",
		"description": "",
		"killable": false
	},
	2: {
		"name": "Steve",
		"occupation": "Unemployed",
		"description": "",
		"killable": true
	},
	3: {
		"name": "Jay",
		"occupation": "Doctor",
		"description": "",
		"killable": false
	},
	4: {
		"name": "Dude",
		"occupation": "Store Owner",
		"description": "",
		"killable": true
	},
	5: {
		"name": "Guy",
		"occupation": "Doctor",
		"description": "",
		"killable": false
	}
}

var current_deed_id = 0
var last_spawned_id = -1
var wrong_choice = false

# Function to pick random deeds
func pick_random_deeds() -> Dictionary:
	var selected_deeds = []
	var total_value = 0
	for i in range(3):
		var deed = deed_list.keys()[randi() % deed_list.size()]
		selected_deeds.append(deed)
		total_value += deed_list[deed]
	return {"description": ", ".join(selected_deeds), "total_value": total_value}

# Function to assign a random deed
func assign_random_deed() -> int:
	if last_spawned_id != -1:
		deeds.erase(last_spawned_id)
	
	var deed_ids = deeds.keys()
	return deed_ids[randi() % deed_ids.size()]

# Function to process a deed
func process_deed(deed_id: int) -> void:
	var deed = deeds[deed_id]
	var random_deeds = pick_random_deeds()
	deed["description"] = random_deeds["description"]
	deed["killable"] = random_deeds["total_value"] < 0
	label_3.text = str("Occupation: ", deed["occupation"])
	label_2.text = str(deed["name"])
	label_4.text = str("Deeds: ", deed["description"])
	print("deed description: ", deed["description"])
	print("Total value: ", random_deeds["total_value"])
	print("Is guilty: ", deed["killable"])

# Function to check if a person is a criminal
func is_criminal(deed_id: int) -> bool:
	return deeds[deed_id]["killable"]

func _ready():
	current_deed_id = assign_random_deed()
	process_deed(current_deed_id)

func on_pressed():
	button_2.disabled = true
	button.disabled = true
	
	wrong_choice = is_criminal(current_deed_id)
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
	
	wrong_choice = is_criminal(current_deed_id)
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
