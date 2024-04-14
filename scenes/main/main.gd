extends Node2D

@onready var music:AudioStreamPlayer = $Music

func _ready():
	music.play();


func _on_stone_enemy_death():
	print("stone death signal")
