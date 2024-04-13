class_name MainMenu
extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button
@onready var credits_button = $MarginContainer/HBoxContainer/VBoxContainer/Credits_Button as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button

func _ready():
	start_button.button_down.connect(on_start_pressed)
	credits_button.button_down.connect(on_credits_pressed)
	exit_button.button_down.connect(on_exit_pressed)

func on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/player/player.tscn")

func on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/credits/credits.tscn")

func on_exit_pressed() -> void:
	get_tree().quit()
