extends CanvasLayer

@onready var label_2 = $%Label2
@onready var label_3 = $%Label3
@onready var label_4 = $%Label4
@onready var animation_player = $AnimationPlayer
@onready var button = $Control/Button
@onready var button_2 = $Control/Button2

# List of deeds with values
var deed_list = {
	"has did shoplifting": {
		"value": -2,
		"hint": "something is missing"
	},
	"stole a banana": {
		"value": -1,
		"hint": "enemy of monkey"
	},
	"was a victim of magic, Apollo": {
		"value": -1,
		"hint": "need hint"
	},
	 "has did vehichular manslaughter": {
		"value": -7,
		"hint": "need hint"
	},
	"Killed a very big moth": {
		"value": 2,
		"hint": "need hint"
	},
	"doesnt smoke": {
		"value": 3,
		"hint": "need hint"
	},
	"doesnt drink": {
		"value": 2,
		"hint": "need hint"
	},
	"drug addict": {
		"value": -2,
		"hint": "need hint"
	},
	"a very happy fella": {
		"value": 1,
		"hint": "need hint"
	},
	"has did tax evasion": {
		"value": -2,
		"hint": "need hint"
	},
	"PISSED ON THE MOON": {
		"value": -2,
		"hint": "need hint"
	},
	"cyberbullied steve jobs": {
		"value": -2,
		"hint": "need hint"
	},
	"likes to walk and talk": {
		"value": 2,
		"hint": "need hint"
	},
	"built an orphanage": {
		"value": 7,
		"hint": "need hint"
	},
	 "saved a guy": {
		"value": 5,
		"hint": "need hint"
	},
	"filthy rich": {
		"value": -1,
		"hint": "need hint"
	},
	"nothing really matters to him": {
		"value": -2,
		"hint": "need hint"
	},
	"killed an eldritch god": {
		"value": -3,
		"hint": "need hint"
	},
	"good boy :3": {
		"value": 2,
		"hint": "need hint"
	},
	"a very healthy fella": {
		"value": 4,
		"hint": "need hint"
	},
	"saved a bird": {
		"value": 3,
		"hint": "need hint"
	},
	"pays his taxes": {
		"value": 2,
		"hint": "need hint"
	},
	"is the child of light": {
		"value": 2,
		"hint": "need hint"
	},
	"could never do wrong": {
		"value": 2,
		"hint": "need hint"
	},
	"solved the fnaf lore": {
		"value": 2,
		"hint": "need hint"
	},
	"hes got a cool hat": {
		"value": 1,
		"hint": "need hint"
	},
	"weed eater": {
		"value": 2,
		"hint": "need hint"
	},
	"put some dirt in your eyes": {
		"value": -1,
		"hint": "memes about dirt and eyes"
	}
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
var hidden_deeds = []

# Function to pick random deeds
func pick_random_deeds() -> Dictionary:
	var selected_deeds = []
	var total_value = 0
	for i in range(GameEvents.deed_count):
		var deed = deed_list.keys()[randi() % deed_list.size()]
		selected_deeds.append(deed)
		total_value += deed_list[deed]["value"]
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
	
	if GameEvents.on_screen > 0:
		# Hide one to two words in the description
		random_deeds["description"] = hide_words_randomly(random_deeds["description"])
	
	person["description"] = random_deeds["description"]
	person["killable"] = random_deeds["total_value"] < 0
	label_3.text = str("Occupation: ", person["occupation"])
	label_2.text = str(person["name"])
	label_4.text = str("Deeds: ", person["description"])
	print("deed description: ", person["description"])
	print("Total value: ", random_deeds["total_value"])
	print("is killable: ", person["killable"])

# Helper function to hide one to two words randomly
func hide_words_randomly(description: String) -> String:
	var words = description.split(", ")
	var num_words_to_hide = randi() % 2 + 1  # Hide one to two words
	var indices_to_hide = []
	while indices_to_hide.size() < num_words_to_hide:
		var index = randi() % words.size()
		if index not in indices_to_hide:
			indices_to_hide.append(index)
	
	for i in indices_to_hide:
		if description.containsn("apollo"):
			hidden_deeds.append(", ".join([words[i-1], words[i]]))
		else :
			hidden_deeds.append(words[i])
		words[i] = "####"
	
	return ", ".join(words)

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
