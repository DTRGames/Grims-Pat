extends Label

@onready var animated_sprite_2d_2 = $AnimatedSprite2D2
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	animated_sprite_2d_2.stop()

func out():
	animation_player.play_backwards("out")
