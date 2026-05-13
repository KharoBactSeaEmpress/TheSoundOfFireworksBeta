extends Control

var questions = [
	{
		"question": "In Python, which keyword is used to create a function?",
		"options": ["func", "define", "def"],
		"correct": 2 
	},
	{
		"question": "Which data type is used to store multiple items in a single variable?",
		"options": ["list", "string", "integer"],
		"correct": 0
	},
	{
		"question": "How do you start a 'for' loop in Python?",
		"options": ["for x in y:", "for(x; y; z)", "loop x in y"],
		"correct": 0
	},
	{
		"question": "Which symbol is used for comments in Python?",
		"options": ["//", "#", "/*"],
		"correct": 1
	},
	{
		"question": "What is the correct extension for Python files?",
		"options": [".pt", ".pyt", ".py"],
		"correct": 2
	}
]

var current_question_index = 0
var score = 0
var is_processing = false 

@onready var question_label = %QuestionLabel
@onready var buttons = [%OptionA, %OptionB, %OptionC]

func _ready():
	MusicPlayer.fade_to_song("res://sounds/music/Eric Skiff - Underclocked  NO COPYRIGHT 8-bit Music  Background.mp3", 0.0, 5.0)
	load_question(0)
	for i in range(buttons.size()):
		buttons[i].pressed.connect(_on_option_selected.bind(i))

func load_question(index):
	if index < questions.size():
		var q = questions[index]
		question_label.text = q["question"]
		for i in range(buttons.size()):
			buttons[i].text = q["options"][i]
			buttons[i].disabled = false 
		is_processing = false 
	else:
		finish_quiz()

func _on_option_selected(index):
	if is_processing: return 
	is_processing = true 
	for btn in buttons:
		btn.disabled = true 
	
	if index == questions[current_question_index]["correct"]:
		score += 1
	
	current_question_index += 1
	
	await get_tree().create_timer(0.2).timeout
	load_question(current_question_index)

func finish_quiz():
	is_processing = true 
	MusicPlayer.fade_out_and_stop(0.5)
	SceneTransition.change_scene("res://scenes/Levels/level_5.tscn")
