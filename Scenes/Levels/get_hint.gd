extends Button

func _ready() -> void:
	await $"../..".ready
	if $"../..".control.hidden_deeds.is_empty():
		visible = false
	GameEvents.leave.connect(on_leave)

func _on_pressed() -> void:
	for i in $"../..".control.hidden_deeds.size():
		var ins = preload("res://Scenes/Levels/hint.tscn").instantiate()
		ins.text = $"../..".control.deed_list[$"../..".control.hidden_deeds[i]]["hint"]
		$"../Hint/VBoxContainer".add_child(ins)
		$"../Hint".visible = true
	
	visible = false

func on_leave():
	if $"../..".control.hidden_deeds.is_empty():
		visible = false
	else :
		visible = true
	
	for hint in $"../Hint/VBoxContainer".get_children():
		hint.queue_free()
