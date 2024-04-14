extends AudioStreamPlayer

const level_music = preload("res://assets/music/Positive_Day.mp3")
const menu_music = preload("res://assets/music/See_the_Light.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	
func play_level_music():
	_play_music(level_music)

func play_menu_music():
	_play_music(menu_music)

func play_SFX(stream: AudioStream, volume = 0.0):
	var sfx_player = AudioStreamPlayer.new()
	sfx_player.stream = stream
	sfx_player.name = "SFX_PLAYER"
	sfx_player.volume_db = volume
	add_child(sfx_player)
	sfx_player.play()
	
	await sfx_player.finished
	
	sfx_player.queue_free()
