extends "res://scenes/mob/mob.gd"

class_name Enemy

func _init():
	# Here you can overwrite parent variables
	pass

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
