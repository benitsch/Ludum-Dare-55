class_name GameOver
extends Control

@onready var back_button = $Back_Button as Button
@onready var label_souls_statistic = $MarginContainer/HBoxContainer/VBoxContainer/LabelSoulsStatistic
@onready var sfx_button_click = preload("res://assets/sfx/button_click.mp3")

func _ready():
	back_button.button_down.connect(on_back_pressed)
	label_souls_statistic.text = "You managed to collect " + str(Autoload.souls) + " souls within " + str(Autoload.current_wave) + " waves."
	AutoloadAudioStreamPlayer.play_menu_music()

func on_back_pressed() -> void:
	Autoload.souls = 0
	Autoload.current_wave = 1
	AutoloadAudioStreamPlayer.play_SFX(sfx_button_click)
	get_tree().change_scene_to_file("res://scenes/ui/main_menu/main_menu.tscn")
