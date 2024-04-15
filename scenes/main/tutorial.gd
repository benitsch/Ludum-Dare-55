extends Node2D

@onready var hud = $Hud
@onready var spawn = $SpawnPoint
@onready var enemy_scene: PackedScene = preload("res://scenes/mob/enemies/pebble.tscn")
var spawn_enemies: bool = false

func _process(_delta):
	if hud.wave_label != null && hud.wave_label.visible:
		hud.wave_label.visible = false
	if hud.wave_timer_label != null && hud.wave_timer_label.visible:
		hud.wave_timer_label.visible = false
	
	if Input.is_action_pressed("load_menu"):
		Autoload.total_souls = 0
		Autoload.souls = 0
		Autoload.current_wave = 1
		Autoload.wave_timer = 30
		get_tree().change_scene_to_file("res://scenes/ui/main_menu/main_menu.tscn")

func _on_timer_timeout():
	if spawn_enemies:
		var temp = enemy_scene.instantiate()
		temp.global_position = spawn.global_position
		add_child(temp)


func _on_area_2d_body_entered(_body):
	spawn_enemies = true


func _on_area_2d_body_exited(_body):
	spawn_enemies = false
