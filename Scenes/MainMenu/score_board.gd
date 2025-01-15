extends Node

var base_score: int = 100
var time: int = 0
var final_score: float = 0.0
var lives: float

@onready var time_label = $Node/Time
@onready var base_score_label = $Node/BaseScore
@onready var final_score_label = $Node/FinalScore
@onready var lost_life = $Node/LostLife
@onready var title = $Node/Title
@onready var animation_player = $AnimationPlayer
@onready var win = $Control/Win
@onready var control = $Control
@onready var click_sound = $ClickSound
@onready var satan = $Satan
@onready var color_rect_2 = $ColorRect2

func _ready() -> void:
	animation_player.play("Enter")
	await animation_player.animation_finished
	if lives <= 0:
		animation_player.play("Lose")
	elif GameEvents.hard_mode and GameEvents.hard_paper_left > 0:
		animation_player.play("Lose")
	elif GameEvents.hard_mode and GameEvents.hard_paper_left <= 0:
		win.visible = true
		animation_player.play("Win")
	else :
		win.visible = true
		animation_player.play("Win")
	await animation_player.animation_finished
	control.visible = false
	satan.visible = false
	animation_player.play("Score")
	

func calculate_score() -> float:
	if time < 300:  # Less than 5 minutes
		final_score = base_score * 2
	elif time < 600:  # Less than 10 minutes
		final_score = base_score * 1.5
	else:  # More than 10 minutes
		final_score = base_score
	
	return final_score

func end_game():
	# Call this function when the game ends
	get_tree().paused = true
	base_score = GameEvents.on_screen
	set_best_time(int(time))
	base_score_label.text = "BASE SCORE: " + str(base_score)
	lost_life.text = "LIFES lEFT: " + str(lives)
	var final_score: float = calculate_score()
	final_score_label.text = "FINAL SCORE: " + str(final_score)
	print("Your final score is: %f" % final_score)
	color_rect_2.z_index = 0

func set_best_time(time_in_seconds: int):
	var seconds = time_in_seconds%60
	var minutes = (time_in_seconds/60)%60
	time_label.text = "TIME: " + "%02d:%02d" % [minutes, seconds]
	

func set_text_gameover():
	title.text = str("YOU ARE FIRED")

func set_text_won():
	title.text = str("YOU WON")

func _on_button_pressed():
	GameEvents.on_screen = 0
	SceneTransion.transion("res://Scenes/MainMenu/main_menu.tscn")


func _on_button_mouse_entered():
	click_sound.play_random()
