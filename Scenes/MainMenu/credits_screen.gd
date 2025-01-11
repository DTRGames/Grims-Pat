extends Control

var contribution = {
	1: {
		"SubTitle": "PROGRAMMER",
		"Contributing": ["person 1", "person 2"],
		"Link": ["person 1 link", "person 2 link"]
	},
	2: {
		"SubTitle": "GRAPHICS",
		"Contributing": ["person 1", "person 2"],
		"Link": ["person 1 link", "person 2 link"]
	},
	3: {
		"SubTitle": "MUSIC/SFX",
		"Contributing": ["person 1", "person 2"],
		"Link": ["person 1 link", "person 2 link"]
	}
}

var license = {
	1: {
		"Name": "m3x6 font by Daniel Linssen",
		"License": "free to use with attribution",
		"Link": "https://managore.itch.io/"
	},
	2: {
		"Name": "m6x11 font by Daniel Linssen",
		"License": "free to use with attribution",
		"Link": "https://managore.itch.io/"
	},
	3: {
		"Name": "Developed with Godot Engine",
		"License": "MIT License",
		"Link": "godotengine.org/license"
	},
	4: {
		"Name": "Godot Engine Logo",
		"License": "CC BY 4.0 International",
		"Link": "https://github.com/godotengine/godot/blob/master/LOGO_LICENSE.txt"
	}
}
@onready var vbox_container = $ScrollContainer/VBoxContainer


func _ready() -> void:
	for i in contribution:
		var sub_title = preload("res://Scenes/MainMenu/credit_sub_title.tscn").instantiate()
		sub_title.get_node("SubTitle").text = contribution[i]["SubTitle"]
		for id in contribution[i]["Contributing"].size():
			var ins = preload("res://Scenes/MainMenu/contribution.tscn").instantiate()
			ins.get_node("Contributing").text = contribution[i]["Contributing"][id]
			ins.get_node("Link").text = contribution[i]["Link"][id]
			sub_title.get_node("Contributions").add_child(ins)
		vbox_container.add_child(sub_title)
	var sub_title = preload("res://Scenes/MainMenu/license_sub_title.tscn").instantiate()
	sub_title.get_node("SubTitle").text = "Other"
	vbox_container.add_child(sub_title)
	for i in license:
		var ins = preload("res://Scenes/MainMenu/license.tscn").instantiate()
		ins.get_node("Name").text = license[i]["Name"]
		ins.get_node("License").text = "License: " + license[i]["License"]
		ins.get_node("Link").text = license[i]["Link"]
		sub_title.get_node("Licenses").add_child(ins)
