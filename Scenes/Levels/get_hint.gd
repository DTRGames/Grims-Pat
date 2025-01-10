extends Button

func _ready() -> void:
	await $"../..".ready
	if $"../..".control.hidden_deeds.is_empty():
		visible = false
	GameEvents.leave.connect(on_leave)

func _on_pressed() -> void:
	var conversation_start = "Heya boss, i found this "
	var additional_hint_start = "Also, I got this from him "
	var combined_hint = conversation_start
	
	for i in range($"../..".control.hidden_deeds.size()):
		var hint = $"../..".control.deed_list[$"../..".control.hidden_deeds[i]]["hint"]
		if i == 0:
			combined_hint += hint
		else:
			combined_hint += "\n" + additional_hint_start + hint
	
	if combined_hint != conversation_start:
		var ins = preload("res://Scenes/Levels/hint.tscn").instantiate()
		ins.text = combined_hint.strip_edges()  # Removing any trailing newline characters
		$"../Hint/VBoxContainer".add_child(ins)
		$"../Hint".visible = true
	
	visible = false

func on_leave():
	if $"../..".control.hidden_deeds.is_empty():
		visible = false
	else:
		visible = true
	
	for hint in $"../Hint/VBoxContainer".get_children():
		hint.queue_free()
