extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func transion(scene):
	get_tree().paused = true
	animation_player.play("transion")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(scene)
	animation_player.play_backwards("transion")
	get_tree().paused = false
