class_name Credits
extends Control

@onready var music:AudioStreamPlayer = $Music
@onready var back_button = $Back_Button as Button

func _ready():
	back_button.button_down.connect(on_back_pressed)
	music.play()

func on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu/main_menu.tscn")
	
