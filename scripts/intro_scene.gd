extends Control

@onready var story_label = $RichTextLabel

var story_lines = [
	"It is 2026.",
	"I'm a normal Computer Science Student.",
	"Unfortunately, we still have work to do even when it's December 31.",
	"There's still lots of things to do.",
	"...",
	"I just slept a few hours ago...",
	"But I hear something..." 
]

var current_line = 0

func _ready() -> void:
	story_label.bbcode_enabled = true 
	story_label.modulate.a = 0 
	show_next_line()

func show_next_line():
	if current_line < story_lines.size():
		story_label.text = story_lines[current_line]
		
		var tween = create_tween()
		tween.tween_property(story_label, "modulate:a", 1.0, 1.5)
		
		if current_line == story_lines.size() - 1:
			shake_screen()
		
		await get_tree().create_timer(5.5).timeout
		
		var fade_out = create_tween()
		fade_out.tween_property(story_label, "modulate:a", 0.0, 1.0)
		await fade_out.finished
		
		current_line += 1
		show_next_line()
	else:
		start_game()

func shake_screen():
	var shake_tween = create_tween()
	for i in range(10):
		shake_tween.tween_property(self, "position", Vector2(randf_range(-5, 5), randf_range(-5, 5)), 0.05)
	shake_tween.tween_property(self, "position", Vector2.ZERO, 0.05)

func start_game():
	SceneTransition.change_scene("res://scenes/Levels/level_1.tscn")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		SceneTransition.change_scene("res://scenes/Levels/level_1.tscn")
