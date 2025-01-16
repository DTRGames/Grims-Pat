extends Control

var in_cooldown = false
var rush_hour_length = 120 # change this
var rush_hour_cooldown = 200 # change this
var rush_hour_paper_left = 7 # change this

@onready var animation_player = $AnimationPlayer
@onready var length = $Length
@onready var cooldown = $Cooldown
@onready var time_left = $TimeLeft
@onready var paper_left = $PaperLeft

func _ready() -> void:
	GameEvents.leave.connect(leave)
	GameEvents.game_over.connect(game_over)
	visible = false
	update_text()

func _process(_delta: float) -> void:
	if GameEvents.rush_hour:
		if not length.is_stopped():
			time_left.text = "Time Left: " + str(int(length.time_left)) + " S"
		paper_left.text = "Paper Left: " + str(GameEvents.rush_hour_paper_left)

func leave():
	if GameEvents.hard_mode and not in_cooldown and not GameEvents.rush_hour:
		var yes_or_no = [true]
		var rush_hour = yes_or_no[randi() % yes_or_no.size()]
		if rush_hour:
			GameEvents.rush_hour = true
			in_cooldown = true
			visible = true
			animation_player.play("Start")
			await animation_player.animation_finished
			length.start(rush_hour_length)
			cooldown.start(rush_hour_cooldown)
	if GameEvents.rush_hour_paper_left <= 0:
		length.stop()
		GameEvents.rush_hour = false
		animation_player.play("End")
		await animation_player.animation_finished
		visible = false
		GameEvents.rush_hour_paper_left = rush_hour_paper_left
		update_text()

func update_text():
	time_left.text = "Time Left: " + str(rush_hour_length) + " S"
	paper_left.text = "Paper Left: " + str(rush_hour_paper_left)

func _on_length_timeout() -> void:
	if GameEvents.rush_hour_paper_left > 0:
		GameEvents.rush_lose = true
		GameEvents.rush_hour_lose.emit()

func _on_cooldown_timeout() -> void:
	in_cooldown = false

func game_over():
	length.stop()
	GameEvents.rush_hour = false
	GameEvents.rush_hour_paper_left = rush_hour_paper_left
