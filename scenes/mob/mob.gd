extends CharacterBody2D

class_name Mob

@export var health: int = 100
@export var damage: int = 10
@export var speed: int = 100
@onready var player = get_node("%Player")

func _init():
	# Here you can overwrite parent variables
	pass
