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
	},
	"stole a banana": {
		"value": -1,
	},
	"was a victim of magic, Apollo": {
		"value": -1,
	},
	 "has did vehichular manslaughter": {
		"value": -7,
		"hint": "he drove over some poor soul"
	},
	"Killed a very big moth": {
		"value": 2,
	},
	"doesnt smoke": {
		"value": 3,
		"hint": "he never smoked in his life"
	},
	"doesnt drink": {
		"value": 2,
		"hint": "he never drunk some booze"
	},
	"drug addict": {
		"value": -2,
		"hint": "he sniffed on the daily"
	},
	"a very happy fella": {
		"value": 1,
		"hint": "he always seemed happy"
	},
	"has did tax evasion": {
		"value": -2,
		"hint": "he.... dear god...even I pay my taxes"
	},
	"PISSED ON THE MOON": {
		"value": -2,
		"hint": "he....PISSED ON THE MOON!!!"
	},
	"cyberbullied steve jobs": {
		"value": -2,
	},
	"likes to walk and talk": {
		"value": 2,
		"hint": "he always liked to walk and talk"
	},
	"built an orphanage": {
		"value": 7,
	},
	 "saved a guy": {
		"value": 5,
		"hint": "he saved a lucky soul"
	},
	"filthy rich": {
		"value": -1,
		"hint": "he thinks he's the next Elon"
	},
	"nothing really matters to him": {
		"value": -2,
		"hint": "he didn't care about anything"
	},
	"killed an eldritch god": {
		"value": -3,
		"hint": "Killed something powerfull"
	},
	"good boy :3": {
		"value": 2,
		"hint": "a very good person"
	},
	"a very healthy fella": {
		"value": 4,
		"hint": "bro looked really healthy"
	},
	"saved a bird": {
		"value": 3,
	},
	"pays his taxes": {
		"value": 2,
		"hint": "he payed his taxes, good"
	},
	"is the child of light": {
		"value": 2,
	},
	"could never do wrong": {
		"value": 2,
	},
	"solved the fnaf lore": {
		"value": 2,
		"hint": "he was Matpat 2.0"
	},
	"hes got a cool hat": {
		"value": 1,
		"hint": "I really love his hat"
	},
	"weed eater": {
		"value": 2,
	},
	"put some dirt in your eyes": {
		"value": -1,
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
		# Hide deeds with hints
		random_deeds["description"] = hide_deeds_with_hints(random_deeds["description"])
	
	person["description"] = random_deeds["description"]
	person["killable"] = random_deeds["total_value"] < 0
	label_3.text = str("Occupation: ", person["occupation"])
	label_2.text = str(person["name"])
	label_4.text = str("Deeds: ", person["description"])
	print("deed description: ", person["description"])
	print("Total value: ", random_deeds["total_value"])
	print("is killable: ", person["killable"])

func hide_deeds_with_hints(description: String) -> String:
	var words = description.split(", ")
	var hidden_count = 0
	for i in range(words.size()):
		if hidden_count >= 2:
			break
		var deed = words[i].strip_edges()
		if deed_list.has(deed) and deed_list[deed].has("hint"):
			hidden_deeds.append(deed)
			words[i] = "####"
			hidden_count += 1
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
