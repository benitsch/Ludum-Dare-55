extends CharacterBody2D

class_name Enemy

@export var health: int = 100
@export var damage: int = 10
@export var speed: int = 200

@export var player: CharacterBody2D

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
