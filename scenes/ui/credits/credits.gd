class_name Credits
extends Control

@onready var music:AudioStreamPlayer = $Music
@onready var back_button = $Back_Button as Button
@onready var sfx_button_click = preload("res://assets/sfx/button_click.mp3")

func _ready():
	back_button.button_down.connect(on_back_pressed)

func on_back_pressed() -> void:
	AutoloadAudioStreamPlayer.play_SFX(sfx_button_click)
	get_tree().change_scene_to_file("res://scenes/ui/main_menu/main_menu.tscn")
	
