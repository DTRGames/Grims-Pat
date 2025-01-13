extends Node2D

var instance = preload("res://Scenes/Levels/control.tscn")
var score_board = preload("res://Scenes/MainMenu/score_board.tscn")
var last_person_id = -1
var lives = 3
var time_passed : float

@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var lives_node = $CanvasLayer/Lives
@onready var control = $Control
var win_on_screen : int

func _process(delta):
	time_passed += delta
	if GameEvents.on_screen == win_on_screen:
		GameEvents.game_over.emit()

func _ready():
	GameEvents.game_over.connect(game_over)
	GameEvents.leave.connect(on_leave)
	GameEvents.lose_life.connect(lose_life)
	last_person_id = control.current_person_id
	win_on_screen = randi_range(40, 50)

func on_leave():
	var ins = instance.instantiate()
	control = ins
	
	if last_person_id != -1:
		control.last_person_id = last_person_id
	
	add_child(ins)
	last_person_id = control.current_person_id

func update_hearts():
	var children = lives_node.get_children()
	for i in range(3):
		if i < lives:
			children[i].show()
		else:
			children[i].hide()

func lose_life():
	lives -= 1
	update_hearts()
	if lives == 0:
		GameEvents.game_over.emit()

func game_over():
	pause_menu.stop = true
	var ins = score_board.instantiate()
	ins.time = time_passed
	ins.lives = lives
	add_child(ins)
	ins.set_text_won()
	if lives == 0:
		ins.set_text_gameover()
	
	ins.end_game()
