extends AudioStreamPlayer

func play_song(new_song: AudioStream):
	if stream != new_song:
		stream = new_song
		play()

func stop_music():
	stop()
