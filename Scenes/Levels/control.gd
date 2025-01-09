extends CanvasLayer

@onready var label_2 = $%Label2
@onready var label_3 = $%Label3
@onready var label_4 = $%Label4
@onready var animation_player = $AnimationPlayer
@onready var button = $Control/Button
@onready var button_2 = $Control/Button2

# List of deeds with values
var deed_list = {
	"has did shoplifting": -2,"stole a banana": -1, "was a victim of magic, Apollo": -1, "has did vehichular manslaughter": -7,
	"Killed a very big moth": 2, "doesnt smoke": 3, "doesnt drink" : 2, "drug addict": -2, "a very happy fella": 1,
	"has did tax evasion": -2, "PISSED ON THE MOON": -2, "cyberbullied steve jobs": -2, "likes to walk and talk": 2,
	"built an orphanage": 7, "saved a guy": 5, "filthy rich": -1, "nothing really matters to him": -2, "killed an eldritch god": -3,
	"good boy :3": 2, "a very healthy fella": 4, "saved a bird": 3, "pays his taxes": 2,"is the child of light" : 2, "could never do wrong": 2,
	"solved the fnaf lore": 2, "hes got a cool hat": 1, "weed eater": 2, "put some dirt in your eyes": -1
}

# person dictionary
var person_list = {
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

var current_person_id = 0
var last_person_id = -1
var wrong_choice = false

# Function to pick random deeds
func pick_random_deeds() -> Dictionary:
	var selected_deeds = []
	var total_value = 0
	for i in range(GameEvents.deed_count):
		var deed = deed_list.keys()[randi() % deed_list.size()]
		selected_deeds.append(deed)
		total_value += deed_list[deed]
	return {"description": ", ".join(selected_deeds), "total_value": total_value}

# Function to assign a random deed
func assign_random_deed() -> int:
	if last_person_id != -1:
		person_list.erase(last_person_id)
	
	var person_id = person_list.keys()
	return person_id[randi() % person_id.size()]

# Function to process a deed
func process_deed(person_id: int) -> void:
	var person = person_list[person_id]
	var random_deeds = pick_random_deeds()
	person["description"] = random_deeds["description"]
	person["killable"] = random_deeds["total_value"] < 0
	label_3.text = str("Occupation: ", person["occupation"])
	label_2.text = str(person["name"])
	label_4.text = str("Deeds: ", person["description"])
	print("deed description: ", person["description"])
	print("Total value: ", random_deeds["total_value"])
	print("is killable: ", person["killable"])

# Function to check if a person is a criminal
func is_killable(person_id: int) -> bool:
	return person_list[person_id]["killable"]

func _ready():
	current_person_id = assign_random_deed()
	process_deed(current_person_id)

func on_pressed():
	button_2.disabled = true
	button.disabled = true
	
	wrong_choice = is_killable(current_person_id)
	if wrong_choice:
		print("Wrong person! This person is innocent.")
		GameEvents.lose_life.emit()
	else:
		print("Correct! Score: ",GameEvents.on_screen)
		GameEvents.on_screen += 1
	
	animation_player.play("Out")
	await animation_player.animation_finished
	GameEvents.leave.emit()
	queue_free()

func on_pressed2():
	button_2.disabled = true
	button.disabled = true
	
	wrong_choice = is_killable(current_person_id)
	if wrong_choice:
		print("Correct! Score: ",GameEvents.on_screen)
		GameEvents.on_screen += 1
	else:
		print("Wrong person! This person is innocent.")
		GameEvents.lose_life.emit()
	
	animation_player.play("Out")
	await animation_player.animation_finished
	GameEvents.leave.emit()
	queue_free()

func _on_button_pressed():
	on_pressed()

func _on_button_2_pressed():
	on_pressed2()
