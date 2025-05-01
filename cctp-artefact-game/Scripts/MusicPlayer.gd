extends AudioStreamPlayer

const silence = preload("res://Assets/Audio/Music/Silence.mp3")
const area_music = preload("res://Assets/Audio/Music/Area1BetterLoop.mp3")
const act2_music = preload("res://Assets/Audio/Music/Area2BetterLoop.mp3")
const lava = preload("res://Assets/Audio/Music/LavaSFX.mp3")
const fake_ending_music = preload("res://Assets/Audio/Music/FakeEnding.mp3")
const final_music = preload("res://Assets/Audio/Music/FinaleBetterLoop.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	stream_paused = false
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()

func play_area_music():
	_play_music(area_music)

func play_area2_music():
	_play_music(act2_music)

func stop_music():
	_play_music(silence)

func play_lava():
	_play_music(lava)

func play_fake_music():
	_play_music(fake_ending_music)

func play_finale():
	_play_music(final_music)
