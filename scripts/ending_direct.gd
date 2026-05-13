extends Control

@onready var story_label = $RichTextLabel

var story_lines = [
	"You find yourself in the same dark place.",
	"You chose to tell Future Ivy that you are from the past.",
	"You were direct with the approach.",
	"The Ivy of the Future saw the message...",
	"And told her friends about it.",
	"Her friends caught on to what the messages meant.",
	"And everyone went insane again.",
	"...",
	"The Ivy of the 15th Loop was not able to leave messages for the next loop.",
	"You have no choice but to place your hope again on the Ivy of the 16th Loop.",
	"You can feel it...",
	"The fireworks are starting again.",
	"You're going back.",
	"And you will hear it again.",
	"The Sound of Fireworks."
]

var current_line = 0

func _ready() -> void:
	MusicPlayer.fade_to_song("res://sounds/music/calice - ivory (unused song).mp3", 0.0, -1.0)
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
	MusicPlayer.fade_out_and_stop(2.5)
	SceneTransition.change_scene("res://scenes/main_menu.tscn")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		MusicPlayer.fade_out_and_stop(2.5)
		SceneTransition.change_scene("res://scenes/main_menu.tscn")
