extends "res://scenes/mob/mob.gd"

class_name Enemy

func _ready():
	super()

func _physics_process(delta):
	super(delta)
	
	if player != null:
		player_direction = global_position.direction_to(player.global_position).normalized()
	else:
		player_direction = Vector2.ZERO
	
	velocity = player_direction * speed
	move_and_slide()
