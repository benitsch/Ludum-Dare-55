extends Node2D

@onready var music:AudioStreamPlayer = $Music

func _ready():
	music.play();
