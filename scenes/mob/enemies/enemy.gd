extends "res://scenes/mob/mob.gd"

class_name Enemy


func _init():
	super()

func _physics_process(delta):
	super(delta)
	
	var direction = Vector2.ZERO
	if player != null:
		direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
