extends Button

@onready var animation_player = $"../../AnimationPlayer"
@onready var sprite_2d = $".."
@onready var click_sound = $"../../PauseMenu/ClickSound"

func _ready() -> void:
	await $"../../..".ready
	if $"../../..".control.hidden_deeds.is_empty():
		get_parent().visible = false
	GameEvents.leave.connect(on_leave)

func _on_pressed() -> void:
	var conversation_start = "Heya boss, I got somethings "
	var additional_hint_start = " Also, "  # Keeping space to separate hints on the same line
	var combined_hint = conversation_start
	
	for i in range($"../../..".control.hidden_deeds.size()):
		var hint = $"../../..".control.deed_list[$"../../..".control.hidden_deeds[i]]["hint"]
		if i == 0:
			combined_hint += hint
		else:
			combined_hint += additional_hint_start + hint
	
	if combined_hint != conversation_start:
		var ins = preload("res://Scenes/Levels/hint.tscn").instantiate()
		ins.get_node("Label").text = combined_hint.strip_edges()  # Removing any trailing whitespace
		$"../../Hint".add_child(ins)
		
		
		$"../../Hint".visible = true
	
	sprite_2d.modulate = "ffffff"
	
	animation_player.play_backwards("out")
	await animation_player.animation_finished
	
	get_parent().visible = false

func on_leave():
	
	if $"../../..".control.hidden_deeds.is_empty():
		
		animation_player.play_backwards("out")
		await animation_player.animation_finished
		get_parent().visible = false
	else:
		
		animation_player.play("out")
		get_parent().visible = true
	
	for hint in $"../../Hint".get_children():
		hint.out()
		await hint.animation_player.animation_finished
		hint.queue_free()


func _on_mouse_entered():
	click_sound.play_random()
	sprite_2d.modulate = "e3e3e3"


func _on_mouse_exited():
	sprite_2d.modulate = "ffffff"
