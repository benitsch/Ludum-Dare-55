class_name MainMenu
extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button
@onready var tutorial_button =  $MarginContainer/HBoxContainer/VBoxContainer/Tutorial_Button as Button
@onready var credits_button = $MarginContainer/HBoxContainer/VBoxContainer/Credits_Button as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var sfx_button_click = preload("res://assets/sfx/button_click.mp3")

func _ready():
	start_button.button_down.connect(on_start_pressed)
	tutorial_button.button_down.connect(on_tutorial_pressed)
	credits_button.button_down.connect(on_credits_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	AutoloadAudioStreamPlayer.play_menu_music()

func on_start_pressed() -> void:
	AutoloadAudioStreamPlayer.play_SFX(sfx_button_click)
	AutoloadAudioStreamPlayer.play_level_music()
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")

func on_tutorial_pressed() -> void:
	AutoloadAudioStreamPlayer.play_SFX(sfx_button_click)
	#AutoloadAudioStreamPlayer.play_level_music()
	get_tree().change_scene_to_file("res://scenes/main/tutorial.tscn")

func on_credits_pressed() -> void:
	AutoloadAudioStreamPlayer.play_SFX(sfx_button_click)
	get_tree().change_scene_to_file("res://scenes/ui/credits/credits.tscn")

func on_exit_pressed() -> void:
	AutoloadAudioStreamPlayer.play_SFX(sfx_button_click)
	get_tree().quit()
