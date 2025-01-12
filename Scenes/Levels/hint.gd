extends Node2D

@onready var animated_sprite_2d_2 = $AnimatedSprite2D2
@onready var animation_player = $AnimationPlayer

func _on_animation_player_animation_finished(anim_name):
	animated_sprite_2d_2.stop()

func out():
	animation_player.play_backwards("out")
