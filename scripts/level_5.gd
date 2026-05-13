extends Node2D
func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	MusicPlayer.fade_to_song("res://sounds/music/A Lonely Cherry Tree.mp3", 0.0, 5.0)
