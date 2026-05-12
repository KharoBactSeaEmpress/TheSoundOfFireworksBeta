extends Control


@export_file("*.tscn") var first_level_path: String

func _ready() -> void:
	if MusicPlayer and not MusicPlayer.is_playing():
		var menu_bgm = load("res://sounds/music/Undertale Extended   025   Dating Start!.mp3") 
		MusicPlayer.volume_db = -15.0
		MusicPlayer.play_song(menu_bgm)

func _on_start_button_pressed() -> void:
	if MusicPlayer:
		MusicPlayer.stop()
	if first_level_path != "":
		SceneTransition.change_scene(first_level_path)
	else:
		print("Error on mainmenu script start ubtton pressed")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
