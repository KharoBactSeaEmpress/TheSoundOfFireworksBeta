extends Node

signal glitch_triggered

var read_note_1: bool = false
var read_note_2: bool = false

var has_experienced_truth: bool = true
var has_experienced_truth_ending: bool = true
var loop_count: int = 1
var final_message_type: String = ""

func trigger_glitch():
	glitch_triggered.emit()

func reset_to_loop():
	has_experienced_truth = true
	get_tree().change_scene_to_file("res://levels/level_1.tscn")
