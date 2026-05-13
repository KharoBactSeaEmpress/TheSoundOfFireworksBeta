extends Node2D

@export var intro_dialogue: DialogueResource
@export var intro_title: String = "start"

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	start_intro_dialogue()
	MusicPlayer.fade_to_song("res://sounds/music/ivory - hope instilled.mp3", 0.0, 5.0)

func start_intro_dialogue():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.is_dialogue_active = true
		var balloon = DialogueManager.show_example_dialogue_balloon(intro_dialogue, intro_title)
		if balloon:
			await balloon.tree_exited
		player.is_dialogue_active = false
