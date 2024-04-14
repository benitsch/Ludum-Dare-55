class_name GameOver
extends Control

@onready var music:AudioStreamPlayer = $Music
@onready var back_button = $Back_Button as Button
@onready var label_souls_statistic = $MarginContainer/HBoxContainer/VBoxContainer/LabelSoulsStatistic

func _ready():
	back_button.button_down.connect(on_back_pressed)
	label_souls_statistic.text = "You managed to collect " + str(Autoload.souls) + " souls."
	music.play()

func on_back_pressed() -> void:
	Autoload.souls = 0
	get_tree().change_scene_to_file("res://scenes/ui/main_menu/main_menu.tscn")
