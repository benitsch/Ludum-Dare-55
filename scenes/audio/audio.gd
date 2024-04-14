extends Node2D

@onready var shoot_sfx:AudioStreamPlayer = $ShootSfx
@onready var music:AudioStreamPlayer = $Music



func _on_button_music_pressed():
	music.play()


func _on_button_sfx_pressed():
	shoot_sfx.play()
