extends AudioStreamPlayer

var current_track_path: String = ""

func fade_to_song(track_input, duration: float = 2.0, target_volume: float = -15.0):
	var new_track
	
	if track_input is String:
		if current_track_path == track_input: return
		current_track_path = track_input
		new_track = load(track_input)
	else:
		new_track = track_input
	
	var tween = create_tween()
	tween.tween_property(self, "volume_db", -10.0, duration / 2)
	tween.tween_callback(func(): 
		stream = new_track
		play()
	)
	tween.tween_property(self, "volume_db", target_volume, duration / 2)

func fade_out_and_stop(duration: float = 1.0):
	var tween = create_tween()
	tween.tween_property(self, "volume_db", -80.0, duration)
	tween.tween_callback(stop)
	current_track_path = ""
