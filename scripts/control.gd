extends Control

var questions = [
	{
		"question": "What is the primary function of a Compiler?",
		"options": ["Run code", "Translate code", "Style code"],
		"correct": 1 
	},
	{
		"question": "Which Godot node is best for 2D physics?",
		"options": ["StaticBody2D", "CharacterBody2D", "Node2D"],
		"correct": 1
	}
]

var current_question_index = 0
var score = 0

@onready var question_label = %QuestionLabel
@onready var buttons = [
	%OptionA,
	%OptionB,
	%OptionC
]

func _ready():
	load_question(0)
	for i in range(buttons.size()):
		buttons[i].pressed.connect(_on_option_selected.bind(i))

func load_question(index):
	if index < questions.size():
		var q = questions[index]
		question_label.text = q["question"]
		for i in range(buttons.size()):
			buttons[i].text = q["options"][i]
	else:
		finish_quiz()

func _on_option_selected(index):
	if index == questions[current_question_index]["correct"]:
		score += 1
		print("Correct!")
	else:
		print("Wrong!")
	
	current_question_index += 1
	load_question(current_question_index)

func finish_quiz():
	print("Quiz over! Score: ", score)
	SceneTransition.change_scene("res://scenes/Levels/level_5.tscn")
