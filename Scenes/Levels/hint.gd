extends Node2D

@onready var animated_sprite_2d_2 = $AnimatedSprite2D2
@onready var animation_player = $AnimationPlayer
@onready var click_sound = $ClickSound
@onready var label = $Label

var visble_characters = 0

#func _process(delta):
	#if visble_characters != label.visible_ratio:
		#visble_characters = label.visible_ratio
		#click_sound.play_random()

func _on_animation_player_animation_finished(anim_name):
	animated_sprite_2d_2.stop()

func out():
	animation_player.play_backwards("out")

func open_face():
	animated_sprite_2d_2.play("default")
