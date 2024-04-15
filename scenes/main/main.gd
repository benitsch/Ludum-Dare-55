extends Node2D


func _process(_delta):
	if Input.is_action_pressed("load_menu"):
		Autoload.total_souls = 0
		Autoload.souls = 0
		Autoload.current_wave = 1
		Autoload.wave_timer = 30
		get_tree().change_scene_to_file("res://scenes/ui/main_menu/main_menu.tscn")
