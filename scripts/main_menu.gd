extends Control
@export_file("*.tscn") var first_level_path: String

func _ready() -> void:
		MusicPlayer.fade_to_song("res://sounds/music/mountain ash (reprise) - whitepine OST.mp3", 0.5, 5.0)

func _on_start_button_pressed() -> void:
	if MusicPlayer:
		MusicPlayer.stop()
	if first_level_path != "":
		MusicPlayer.fade_out_and_stop(0.5)
		SceneTransition.change_scene(first_level_path)
	else:
		print("Error on mainmenu script start ubtton pressed")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
